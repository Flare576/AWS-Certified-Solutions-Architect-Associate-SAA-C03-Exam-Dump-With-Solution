#!/usr/bin/env bash
# macOS / Linux: map aws.certification.edu to this machine, then serve the viewer on localhost only.
set -euo pipefail

HOST=aws.certification.edu
PORT="${PORT:-80}"
URL="http://$HOST/"
[ "$PORT" = 80 ] || URL="http://$HOST:$PORT/"

cd "$(dirname "$0")"

if ! grep -qE "^[^#]*[[:space:]]${HOST//./\\.}([[:space:]]|\$)" /etc/hosts; then
  echo "Adding $HOST to /etc/hosts (sudo password may be requested)..."
  echo "127.0.0.1 $HOST" | sudo tee -a /etc/hosts >/dev/null
fi

(
  sleep 1
  if command -v open >/dev/null 2>&1; then open "$URL"
  elif command -v xdg-open >/dev/null 2>&1; then xdg-open "$URL"
  fi
) &

echo "Serving $URL (Ctrl+C to stop)"
if [ "$PORT" -lt 1024 ] && [ "$(id -u)" -ne 0 ]; then
  # Root is only needed to bind the port; serve.py drops back to your user right after.
  exec sudo python3 serve.py "$PORT"
fi
exec python3 serve.py "$PORT"
