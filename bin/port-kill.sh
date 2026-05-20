#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: port-kill.sh [options] <port>

Kill processes bound to a port.

Options:
  -9, --force            send SIGKILL instead of SIGTERM
  -s, --signal SIGNAL    send a custom signal, such as HUP or KILL
  -h, --help             show this help message

Examples:
  port-kill.sh 3000
  port-kill.sh --force 5173
  port-kill.sh --signal HUP 8080
EOF
}

signal="TERM"
port=""

while (($#)); do
  case "$1" in
    -9|--force)
      signal="KILL"
      shift
      ;;
    -s|--signal)
      shift
      if (($# == 0)); then
        echo "Missing signal name."
        usage
        exit 1
      fi
      signal="$1"
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
      if [[ -n "$port" ]]; then
        echo "Only one port can be provided."
        usage
        exit 1
      fi
      port="$1"
      shift
      ;;
  esac
done

if [[ -z "$port" || ! "$port" =~ ^[0-9]+$ || "$port" -lt 1 || "$port" -gt 65535 ]]; then
  echo "Please provide a valid port number between 1 and 65535."
  usage
  exit 1
fi

find_pids() {
  if command -v lsof >/dev/null 2>&1; then
    {
      lsof -tiTCP:"$port" -sTCP:LISTEN 2>/dev/null || true
      lsof -tiUDP:"$port" 2>/dev/null || true
    } | awk 'NF' | sort -u
    return
  fi

  if command -v fuser >/dev/null 2>&1; then
    fuser -n tcp "$port" 2>/dev/null | tr ' ' '\n' | awk 'NF' | sort -u
    return
  fi

  if command -v ss >/dev/null 2>&1; then
    ss -ltnup "( sport = :$port )" 2>/dev/null |
      awk -F'pid=' '/pid=/{split($2, a, ","); print a[1]}' | awk 'NF' | sort -u
    return
  fi

  echo "No supported port inspection tool found. Install lsof, fuser, or ss." >&2
  exit 1
}

mapfile -t pids < <(find_pids)

if ((${#pids[@]} == 0)); then
  echo "No process is bound to port $port."
  exit 0
fi

echo "Processes bound to port $port:"
ps -fp "${pids[@]}" || true
echo
echo "Sending SIG${signal} to: ${pids[*]}"
kill "-${signal}" "${pids[@]}"

sleep 1
mapfile -t remaining < <(find_pids)
if ((${#remaining[@]} > 0)); then
  echo "Some processes are still bound to port $port: ${remaining[*]}"
  exit 1
fi

echo "Port $port is now free."
