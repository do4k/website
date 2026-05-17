#!/usr/bin/env bash
set -euo pipefail

HUGO_VERSION="0.161.1"
HUGO_URL="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"

if ! hugo version | grep -q "v${HUGO_VERSION}"; then
    echo "Downloading Hugo v${HUGO_VERSION}..."
    curl -sL "$HUGO_URL" | tar xz hugo
    chmod +x hugo
    ./hugo --gc --minify "$@"
else
    hugo --gc --minify "$@"
fi
