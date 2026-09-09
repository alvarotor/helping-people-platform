#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

test -f .env.example
test -f nginx/default.conf
docker compose --env-file .env.example config --quiet
printf '%s\n' 'platform verification passed'
