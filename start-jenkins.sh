#!/usr/bin/env bash

set -euo pipefail

echo "🔄 Building and starting Jenkins container..."
docker-compose up -d --build

echo "⏳ Waiting for Jenkins to start..."
# Wait for Jenkins to fully start (up to 60 seconds)
for i in {1..12}; do
  if docker exec jenkins curl -s -I http://localhost:8080/login >/dev/null 2>&1; then
    echo "Jenkins is up and running!"
    break
  fi
  echo "Still waiting... ($i/12)"
  sleep 5
done

echo "✅ Jenkins is running at http://localhost:8080"
