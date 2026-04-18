#!/usr/bin/env bash

set -euo pipefail

docker build \
    --platform linux/amd64 \
    -t vertex:latest \
    -f DockerfileVertex \
    .
