#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

go test --coverage=atomic -coverprofile=coverage.txt ./...
