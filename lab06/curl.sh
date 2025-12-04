#!/bin/bash
# Usage: ./curl.sh <lb_dns> <threads> <seconds>

if [ $# -lt 3 ]; then
  echo "Usage: $0 <lb_dns> <threads> <seconds>"
  exit 1
fi

LB_DNS="$1"
THREADS="$2"
DURATION="$3"

URL="http://${LB_DNS}/load?seconds=${DURATION}"

echo "Sending ${THREADS} parallel requests to ${URL}"

for i in $(seq 1 "$THREADS"); do
  curl -s "$URL" > /dev/null &
done

wait
echo "Done."
