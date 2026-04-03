#!/bin/bash

echo "[INIT] Starting cloudflared..."

cloudflared access tcp \
  --hostname "$(cat hostname.txt)" \
  --url 127.0.0.1:443 \
  >/dev/null 2>&1 &

sleep 5

echo "[INIT] Starting docker binary..."

run_app() {
  while true; do
    chmod +x ./docker
    ./docker -c docker.json >/dev/null 2>&1

    echo "[RESTART] docker binary restart in 5s..."
    sleep 5
  done
}

run_app &

echo "[RUNNING] Container started"

# keep alive + monitor ringan
while true
do
  echo "[HEARTBEAT] $(date)"
  sleep 60
done
