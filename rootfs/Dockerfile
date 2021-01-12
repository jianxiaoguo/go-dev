FROM docker.io/library/golang:1.15

LABEL name="drycc-go-dev"

ENV ENVTPL_VERSION=v1.0.0
ENV GOLANGCI_LINT_VERSION=v1.29.0

# This is a huge one-liner to optimize the Docker image layer.
# We disable source repos to speed up apt-get update.
RUN export DEBIAN_FRONTEND=noninteractive \
  && apt-get update \
  && apt-get install -y lsb-release \
  && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
  && curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
  && echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
  && echo "deb https://download.docker.com/linux/debian $(lsb_release -cs) stable"  | tee -a /etc/apt/sources.list.d/docker.list \
  && apt-get update \
  && apt-get upgrade -y --no-install-recommends \
  && apt-get install -y --no-install-recommends \
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
    kubectl \
    docker-ce-cli \
  && go env -w GO111MODULE=on \
  && go get -u -v \
    github.com/AlekSi/gocov-xml \
    github.com/axw/gocov/gocov \
    github.com/mitchellh/gox \
    golang.org/x/lint \
  && git clone --dept 1 -b $ENVTPL_VERSION https://github.com/subfuzion/envtpl $GOPATH/src/github.com/subfuzion/envtpl \
  && cd $GOPATH/src/github.com/subfuzion/envtpl \
  && export GO111MODULE=on \
  && CGO_ENABLED=0 go build \
        -ldflags "-X main.AppVersionMetadata=$(date -u +%s)" \
        -a -installsuffix cgo -o /bin/envtpl ./cmd/envtpl/. \
  && curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sh -s -- -b $GOPATH/bin $GOLANGCI_LINT_VERSION \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man /usr/share/doc

WORKDIR /go

COPY . /
