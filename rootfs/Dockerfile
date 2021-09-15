FROM docker.io/library/golang:1.17

LABEL name="drycc-go-dev"

ENV ENVTPL_VERSION=v1.0.0
ENV GOLANGCI_LINT_VERSION=v1.42.1

# This is a huge one-liner to optimize the Docker image layer.
# We disable source repos to speed up apt-get update.
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update -y --no-install-recommends \
  && apt-get install -y --no-install-recommends \
    lsb-release \
    bash \
    build-essential \
    ca-certificates \
    curl \
    git-core \
    jq \
    libffi-dev \
    libssl-dev \
    man \
    mercurial \
    net-tools \
    netcat \
    openssh-client \
    procps \
    rsync \
    ruby \
    unzip \
    upx \
    util-linux \
    vim \
    wget \
    zip \
    shellcheck \
    etcd \
    podman \
    fuse-overlayfs \
  && curl -o /usr/local/bin/kubectl \
    -L "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$(dpkg --print-architecture)/kubectl" \
  && chmod +x /usr/local/bin/kubectl \
  && go env -w GO111MODULE=on \
  && go get -u -v \
    github.com/AlekSi/gocov-xml \
    github.com/axw/gocov/gocov \
    github.com/mitchellh/gox \
    github.com/mgechev/revive \
  && git clone --dept 1 -b $ENVTPL_VERSION https://github.com/subfuzion/envtpl $GOPATH/src/github.com/subfuzion/envtpl \
  && cd $GOPATH/src/github.com/subfuzion/envtpl \
  && export GO111MODULE=on \
  && CGO_ENABLED=0 go build \
        -ldflags "-X main.AppVersionMetadata=$(date -u +%s)" \
        -a -installsuffix cgo -o /bin/envtpl ./cmd/envtpl/. \
  && git clone --dept 1 https://github.com/buildpacks/pack -b v0.21.0 /tmp/pack \
  && cd /tmp/pack \
  && make \
  && cp /tmp/pack/out/pack /usr/local/bin \
  && chmod +x /usr/local/bin/pack \
  && rm -rf /tmp/pack \
  && curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sh -s -- -b $GOPATH/bin $GOLANGCI_LINT_VERSION \
  && bash -c "mkdir -p /var/lib/shared/{overlay-images,overlay-layers}" \
  && bash -c "touch /var/lib/shared/{overlay-images/images.lock,overlay-layers/layers.lock}" \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man /usr/share/doc

WORKDIR /go

COPY . /
