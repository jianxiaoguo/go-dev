FROM registry.drycc.cc/drycc/base:bullseye

LABEL name="drycc-go-dev"

ENV GO_VERSION=1.20.4
ENV GOLANGCI_LINT_VERSION=v1.53.0

# This is a huge one-liner to optimize the Docker image layer.
# We disable source repos to speed up apt-get update.
RUN export DEBIAN_FRONTEND=noninteractive \
  && install-packages \
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
  && install-stack go $GO_VERSION && . init-stack \
  && curl -o /usr/local/bin/kubectl \
    -L "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$(dpkg --print-architecture)/kubectl" \
  && chmod +x /usr/local/bin/kubectl \
  && go env -w GO111MODULE=on \
  && go install github.com/AlekSi/gocov-xml@latest \
  && go install github.com/axw/gocov/gocov@latest \
  && go install github.com/mitchellh/gox@latest \
  && go install github.com/mgechev/revive@latest \
  && curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $(go env GOPATH)/bin $GOLANGCI_LINT_VERSION \
  && mkdir -p /var/lib/shared/{overlay-images,overlay-layers} \
  && touch /var/lib/shared/{overlay-images/images.lock,overlay-layers/layers.lock} \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man /usr/share/doc

WORKDIR /opt/drycc/go

COPY . /
