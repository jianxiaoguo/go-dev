#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

go test --covermode=atomic -coverprofile=coverage.txt ./...
