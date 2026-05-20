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

  if [[ "${capture_backend}" != "auto" ]]; then
    preferred=("$capture_backend")
  elif [[ "${XDG_CURRENT_DESKTOP:-}" == *KDE* ]]; then
    preferred=(flameshot spectacle grim maim)
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
