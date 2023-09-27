VERSION ?= $(shell git describe --tags --exact-match 2>/dev/null || echo latest)
DEV_REGISTRY ?= registry.drycc.cc
IMAGE_PREFIX ?= drycc
IMAGE := ${DEV_REGISTRY}/${IMAGE_PREFIX}/go-dev:${VERSION}
PLATFORM ?= linux/amd64,linux/arm64

# scripts are checked *after* build, so use paths inside the container
SHELL_SCRIPTS = /usr/local/bin/test-cover.sh

# container development environment variables
DEV_ENV_PREFIX := podman run --rm
DEV_ENV_CMD := ${DEV_ENV_PREFIX} ${IMAGE}

info:
	@echo "REGISTRY: ${REGISTRY}"
	@echo "VERSION:  ${VERSION}"
	@echo "IMAGE:    ${IMAGE}"

build:
	podman build --build-arg CODENAME=${CODENAME} -t ${IMAGE} rootfs

push: build
	podman push ${IMAGE}

test: build
	${DEV_ENV_CMD} shellcheck $(SHELL_SCRIPTS)
