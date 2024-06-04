#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

go test --covermode=atomic -coverprofile=coverage.txt ./...
if [[ -n $CODECOV_TOKEN ]]; then
  codecov upload-process --plugin=noop -t "$CODECOV_TOKEN"
fi
