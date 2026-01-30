#!/usr/bin/env bash

set -euo pipefail

config_files="${JEKYLL_CONFIG:-_config.yml}"
if [[ -z "${JEKYLL_CONFIG:-}" && -f _config.dev.yml ]]; then
  config_files="_config.yml,_config.dev.yml"
fi

IFS=',' read -r -a watch_files <<< "$config_files"

start_jekyll() {
  bundle exec jekyll serve \
    --config "$config_files" \
    --watch \
    --port=8080 \
    --host=0.0.0.0 \
    --livereload \
    --verbose \
    --trace \
    --force_polling &
  jekyll_pid=$!
}

start_jekyll

while true; do
  inotifywait -q -e modify,move,create,delete "${watch_files[@]}"
  echo "Config change detected, restarting Jekyll"
  kill -KILL "$jekyll_pid" 2>/dev/null || true
  start_jekyll
done
