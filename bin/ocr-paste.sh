#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: ocr-paste.sh [options] [image-file]

Capture a screen region or read an image file, run OCR, copy the result
to the clipboard, and print the text to stdout.

Options:
  -l, --lang LANG        tesseract languages (default: eng+chi_sim)
  -p, --psm MODE         tesseract page segmentation mode (default: 6)
  -b, --backend NAME     capture backend: auto, spectacle, flameshot, grim,
                         hyprshot, or maim (default: auto)
      --from-clipboard   OCR the current clipboard image instead of capturing
      --no-copy          do not write the OCR result to the clipboard
      --no-notify        do not send a desktop notification
      --raw              skip image preprocessing
  -h, --help             show this help message

Examples:
  ocr-paste.sh
  ocr-paste.sh screenshot.png
  ocr-paste.sh --backend spectacle
  ocr-paste.sh --lang eng --psm 7
EOF
}

have() {
  command -v "$1" >/dev/null 2>&1
}

image_convert() {
  if have magick; then
    magick "$@"
  else
    convert "$@"
  fi
}

image_identify() {
  if have magick; then
    magick identify "$@"
  else
    identify "$@"
  fi
}

notify() {
  local title="$1"
  local body="${2:-}"
  if ((notify_enabled == 1)) && have notify-send; then
    notify-send "$title" "$body" >/dev/null 2>&1 || true
  fi
}

debug_log() {
  if ((debug_enabled == 1)); then
    printf 'ocr-paste: %s\n' "$*" >&2
  fi
}

list_enabled_screens() {
  if have kscreen-doctor && have jq; then
    kscreen-doctor -j 2>/dev/null | jq -r '
      .outputs[]
      | select(.enabled == true and .connected == true)
      | [
          .name,
          (.pos.x // 0),
          (.pos.y // 0),
          (.size.width // 0),
          (.size.height // 0)
        ]
      | @tsv
    ' 2>/dev/null
    return 0
  fi

  if have kscreen-doctor; then
    kscreen-doctor -o 2>/dev/null | awk '
      /^Output:/ {
        current_name = $3
        current_enabled = 0
        for (i = 4; i <= NF; i++) {
          if ($i == "enabled") {
            current_enabled = 1
          }
          if ($i == "disconnected") {
            current_enabled = 0
          }
        }
        next
      }
      /Geometry:/ && current_enabled {
        if (match($0, /Geometry: ([0-9-]+),([0-9-]+) ([0-9]+)x([0-9]+)/, m)) {
          print current_name "\t" m[1] "\t" m[2] "\t" m[3] "\t" m[4]
        }
      }
    '
    return 0
  fi

  return 1
}

capture_region_kde_wayland() {
  local output="$1"
  local region=""
  local rx ry rw rh
  local cx cy
  local output_name=""
  local screen_x="" screen_y="" screen_w="" screen_h=""
  local full_png="${output%.png}.full.png"
  local image_w image_h
  local crop_x crop_y crop_w crop_h

  if ! have slurp || ! have kscreen-doctor; then
    return 1
  fi

  if ! region="$(slurp 2>/dev/null)" || [[ -z "$region" ]]; then
    debug_log "region selection cancelled"
    return 1
  fi

  if [[ ! "$region" =~ ^([0-9-]+),([0-9-]+)\ ([0-9]+)x([0-9]+)$ ]]; then
    debug_log "unexpected slurp output: $region"
    return 1
  fi

  rx="${BASH_REMATCH[1]}"
  ry="${BASH_REMATCH[2]}"
  rw="${BASH_REMATCH[3]}"
  rh="${BASH_REMATCH[4]}"
  cx=$((rx + rw / 2))
  cy=$((ry + rh / 2))

  while IFS=$'\t' read -r name x y w h; do
    [[ -z "$name" ]] && continue
    debug_log "detected screen=$name geometry=${x},${y} ${w}x${h}"
    if ((cx >= x && cx < x + w && cy >= y && cy < y + h)); then
      output_name="$name"
      screen_x="$x"
      screen_y="$y"
      screen_w="$w"
      screen_h="$h"
      break
    fi
  done < <(list_enabled_screens)

  if [[ -z "$output_name" ]]; then
    if ((debug_enabled == 1)) && have kscreen-doctor; then
      debug_log "raw kscreen-doctor -j:"
      kscreen-doctor -j 2>&1 | sed 's/^/ocr-paste:   /' >&2 || true
      debug_log "raw kscreen-doctor -o:"
      kscreen-doctor -o 2>&1 | sed 's/^/ocr-paste:   /' >&2 || true
    fi
    debug_log "could not match selected region to an enabled screen"
    return 1
  fi

  debug_log "selected region=$region mapped to screen=$output_name geometry=${screen_x},${screen_y} ${screen_w}x${screen_h}"

  rm -f "$full_png"
  if ! spectacle --current --background --nonotify --output "$full_png" >/dev/null 2>&1 || [[ ! -s "$full_png" ]]; then
    debug_log "spectacle current-screen capture failed"
    return 1
  fi

  if ! read -r image_w image_h < <(image_identify -format '%w %h' "$full_png" 2>/dev/null); then
    debug_log "failed to identify captured image size"
    return 1
  fi

  crop_x=$(((rx - screen_x) * image_w / screen_w))
  crop_y=$(((ry - screen_y) * image_h / screen_h))
  crop_w=$((rw * image_w / screen_w))
  crop_h=$((rh * image_h / screen_h))

  ((crop_x < 0)) && crop_x=0
  ((crop_y < 0)) && crop_y=0
  ((crop_w < 1)) && crop_w=1
  ((crop_h < 1)) && crop_h=1
  ((crop_x + crop_w > image_w)) && crop_w=$((image_w - crop_x))
  ((crop_y + crop_h > image_h)) && crop_h=$((image_h - crop_y))

  if ((crop_w < 1 || crop_h < 1)); then
    debug_log "computed crop is invalid: ${crop_w}x${crop_h}+${crop_x}+${crop_y}"
    return 1
  fi

  debug_log "cropping captured screen ${image_w}x${image_h} to ${crop_w}x${crop_h}+${crop_x}+${crop_y}"
  image_convert "$full_png" -crop "${crop_w}x${crop_h}+${crop_x}+${crop_y}" +repage "$output"
  [[ -s "$output" ]]
}

copy_clipboard() {
  local text="$1"

  if have wl-copy && [[ "${XDG_SESSION_TYPE:-}" == "wayland" ]]; then
    printf '%s' "$text" | wl-copy
    return 0
  fi

  if have xclip; then
    printf '%s' "$text" | xclip -selection clipboard -in
    return 0
  fi

  if have xsel; then
    printf '%s' "$text" | xsel --clipboard --input
    return 0
  fi

  return 1
}

clipboard_image_type() {
  if have wl-paste && [[ "${XDG_SESSION_TYPE:-}" == "wayland" ]]; then
    wl-paste --list-types 2>/dev/null | awk '/^image\// { print; exit }'
    return 0
  fi

  return 1
}

save_clipboard_image() {
  local output="$1"
  local mime=""

  if have wl-paste && [[ "${XDG_SESSION_TYPE:-}" == "wayland" ]]; then
    mime="$(clipboard_image_type || true)"
    if [[ -n "$mime" ]]; then
      wl-paste --type "$mime" > "$output"
      [[ -s "$output" ]]
      return
    fi
  fi

  return 1
}

capture_region() {
  local output="$1"
  local preferred=()
  local backend
  local on_kde_wayland=0

  if [[ "${XDG_CURRENT_DESKTOP:-}" == *KDE* ]] && [[ "${XDG_SESSION_TYPE:-}" == "wayland" ]]; then
    on_kde_wayland=1
  fi

  if [[ "${capture_backend}" != "auto" ]]; then
    preferred=("$capture_backend")
  elif ((on_kde_wayland == 1)); then
    preferred=(spectacle flameshot maim)
  elif [[ "${XDG_CURRENT_DESKTOP:-}" == *KDE* ]]; then
    preferred=(flameshot spectacle maim)
  elif [[ "${XDG_CURRENT_DESKTOP:-}" == *Hyprland* ]]; then
    preferred=(hyprshot grim flameshot spectacle maim)
  elif [[ "${XDG_SESSION_TYPE:-}" == "wayland" ]]; then
    preferred=(grim spectacle flameshot hyprshot maim)
  else
    preferred=(maim spectacle flameshot grim hyprshot)
  fi

  for backend in "${preferred[@]}"; do
    rm -f "$output"
    case "$backend" in
      spectacle)
        if have spectacle; then
          if ((on_kde_wayland == 1)); then
            if capture_region_kde_wayland "$output"; then
              return 0
            fi
            debug_log "KDE Wayland spectacle region workaround failed"
            continue
          fi
          if spectacle --region --background --nonotify --output "$output" >/dev/null 2>&1 && [[ -s "$output" ]]; then
            return 0
          fi
          debug_log "spectacle capture failed"
        fi
        ;;
      flameshot)
        if have flameshot; then
          if flameshot gui --accept-on-select --raw > "$output" 2>/dev/null && [[ -s "$output" ]]; then
            return 0
          fi
          debug_log "flameshot capture failed"
        fi
        ;;
      grim)
        if have grim && have slurp && [[ "${XDG_SESSION_TYPE:-}" == "wayland" ]]; then
          local region=""
          if region="$(slurp 2>/dev/null)" && [[ -n "$region" ]]; then
            if grim -g "$region" "$output" >/dev/null 2>&1 && [[ -s "$output" ]]; then
              return 0
            fi
            debug_log "grim capture failed"
          else
            debug_log "region selection cancelled"
          fi
        fi
        ;;
      hyprshot)
        if have hyprshot && [[ "${XDG_CURRENT_DESKTOP:-}" == *Hyprland* ]]; then
          if hyprshot -m region -o "$(dirname "$output")" -f "$(basename "$output")" -s >/dev/null 2>&1 && [[ -s "$output" ]]; then
            return 0
          fi
          debug_log "hyprshot capture failed"
        fi
        ;;
      maim)
        if have maim && have slop; then
          if maim -s "$output" >/dev/null 2>&1 && [[ -s "$output" ]]; then
            return 0
          fi
          debug_log "maim capture failed"
        fi
        ;;
    esac
  done

  return 1
}

preprocess_image() {
  local input="$1"
  local output="$2"

  if ((raw_mode == 1)) || (! have magick && ! have convert); then
    cp "$input" "$output"
    return 0
  fi

  image_convert "$input" \
    -alpha off \
    -strip \
    -colorspace Gray \
    -resize 200% \
    -contrast-stretch 1%x1% \
    -sharpen 0x1 \
    "$output"
}

lang="${OCR_PASTE_LANG:-eng+chi_sim}"
psm="${OCR_PASTE_PSM:-6}"
capture_backend="${OCR_PASTE_BACKEND:-auto}"
copy_enabled=1
notify_enabled=1
raw_mode=0
from_clipboard=0
debug_enabled="${OCR_PASTE_DEBUG:-0}"
image_file=""

while (($#)); do
  case "$1" in
    -l|--lang)
      shift
      if (($# == 0)); then
        echo "Missing value for --lang."
        usage
        exit 1
      fi
      lang="$1"
      shift
      ;;
    -p|--psm)
      shift
      if (($# == 0)); then
        echo "Missing value for --psm."
        usage
        exit 1
      fi
      psm="$1"
      shift
      ;;
    -b|--backend)
      shift
      if (($# == 0)); then
        echo "Missing value for --backend."
        usage
        exit 1
      fi
      capture_backend="$1"
      shift
      ;;
    --from-clipboard)
      from_clipboard=1
      shift
      ;;
    --no-copy)
      copy_enabled=0
      shift
      ;;
    --no-notify)
      notify_enabled=0
      shift
      ;;
    --raw)
      raw_mode=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    -*)
      echo "Unknown option: $1"
      usage
      exit 1
      ;;
    *)
      if [[ -n "$image_file" ]]; then
        echo "Only one image file can be provided."
        usage
        exit 1
      fi
      image_file="$1"
      shift
      ;;
  esac
done

if ! have tesseract; then
  echo "tesseract is not installed."
  exit 1
fi

if ! [[ "$psm" =~ ^[0-9]+$ ]]; then
  echo "PSM must be a number."
  exit 1
fi

case "$capture_backend" in
  auto|spectacle|flameshot|grim|hyprshot|maim)
    ;;
  *)
    echo "Unsupported backend: $capture_backend"
    usage
    exit 1
    ;;
esac

tmp_dir="$(mktemp -d)"
trap 'rm -rf "$tmp_dir"' EXIT

source_png="$tmp_dir/source.png"
work_png="$tmp_dir/work.png"
text_file="$tmp_dir/result.txt"

if [[ -n "$image_file" ]]; then
  if [[ ! -f "$image_file" ]]; then
    echo "Image not found: $image_file"
    exit 1
  fi
  cp "$image_file" "$source_png"
elif ((from_clipboard == 1)); then
  if ! save_clipboard_image "$source_png"; then
    echo "Clipboard does not contain an image."
    notify "OCR failed" "Clipboard does not contain an image."
    exit 1
  fi
else
  if ! capture_region "$source_png"; then
    if save_clipboard_image "$source_png"; then
      debug_log "capture failed, using clipboard image instead"
    else
      echo "Capture failed or was cancelled."
      notify "OCR cancelled" "Capture failed or was cancelled."
      exit 1
    fi
  fi
  if [[ ! -s "$source_png" ]]; then
    echo "Capture did not produce an image."
    notify "OCR cancelled" "Capture did not produce an image."
    exit 1
  fi
fi

preprocess_image "$source_png" "$work_png"

if ! tesseract "$work_png" "$tmp_dir/result" -l "$lang" --oem 3 --psm "$psm" -c preserve_interword_spaces=1 >/dev/null 2>&1; then
  echo "tesseract failed. Check that language data for '$lang' is installed."
  notify "OCR failed" "tesseract could not process the image."
  exit 1
fi

if [[ ! -f "$text_file" ]]; then
  echo "OCR produced no output."
  exit 1
fi

text="$(sed 's/\f//g' "$text_file")"

if [[ -z "${text//[[:space:]]/}" ]]; then
  echo "No text recognized."
  notify "OCR finished" "No text was recognized."
  exit 1
fi

if ((copy_enabled == 1)); then
  if copy_clipboard "$text"; then
    :
  else
    echo "OCR succeeded, but no clipboard tool is available." >&2
    notify "OCR finished" "Text recognized, but clipboard copy failed."
  fi
fi

printf '%s\n' "$text"

preview="$(printf '%s' "$text" | tr '\n' ' ' | cut -c1-120)"
if ((copy_enabled == 1)); then
  notify "OCR copied to clipboard" "$preview"
else
  notify "OCR finished" "$preview"
fi
