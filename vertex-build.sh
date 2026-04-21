#!/usr/bin/env bash

set -euo pipefail

THIS_SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

set -a
# shellcheck disable=SC1091
[[ -f $THIS_SCRIPT_DIR/.env ]] && source "$THIS_SCRIPT_DIR/.env"
set +a

docker build \
    --platform linux/amd64 \
    -t vertex:latest \
    -f DockerfileVertex \
    --secret "id=ipinfo_token,env=IPINFO_TOKEN" \
    .
