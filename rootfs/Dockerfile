FROM ubuntu:20.04

LABEL name="drycc-go-dev"

ENV AZCLI_VERSION=2.9.1 \
    DOCKER_VERSION=19.03.9  \
    GO_VERSION=1.14.6 \
    KUBECTL_VERSION=v1.18.6 \
    SHELLCHECK_VERSION=v0.7.1 \
    ETCDCTL_VERSION=v3.4.10 \
    GOLANGCI_LINT_VERSION=v1.29.0 \
    PATH=$PATH:/usr/local/go/bin:/go/bin:/usr/local/bin/docker \
    GOPATH=/go

# This is a huge one-liner to optimize the Docker image layer.
# We disable source repos to speed up apt-get update.
RUN \
  sed -i -e 's/^deb-src/#deb-src/' /etc/apt/sources.list && \
  export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get upgrade -y --no-install-recommends && \
  apt-get install -y --no-install-recommends \
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
    python3 \
    python3-dev \
    python3-pip \
    rsync \
    ruby \
    unzip \
    upx \
    util-linux \
    vim \
    wget \
    zip \
  && wget https://github.com/koalaman/shellcheck/releases/download/$SHELLCHECK_VERSION/shellcheck-$SHELLCHECK_VERSION.linux.x86_64.tar.xz \
    && xz -d shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar.xz \
    && tar -xvf shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar \
    && cp shellcheck-${SHELLCHECK_VERSION}/shellcheck /usr/local/bin/ \
    && chmod +x /usr/local/bin/shellcheck \
    && rm -rf shellcheck-${SHELLCHECK_VERSION} shellcheck-${SHELLCHECK_VERSION}.linux.x86_64.tar \
  && curl -L https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz | tar -C /usr/local -xz \
  && curl -sSL https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
  && chmod +x /usr/local/bin/kubectl \
  && mkdir -p /go/bin \
  && apt-get update && apt-get -f -y install \
  && curl -fsSLO https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz \
  && tar xzvf docker-$DOCKER_VERSION.tgz -C /usr/local/bin \
  && chmod +x -R /usr/local/bin/docker \
  && rm docker-$DOCKER_VERSION.tgz \
  && curl -L https://github.com/coreos/etcd/releases/download/$ETCDCTL_VERSION/etcd-$ETCDCTL_VERSION-linux-amd64.tar.gz -o /tmp/etcd-$ETCDCTL_VERSION.tar.gz \
  && tar -C /tmp -xvzf /tmp/etcd-$ETCDCTL_VERSION.tar.gz --strip-components=1 etcd-$ETCDCTL_VERSION-linux-amd64/etcdctl \
  && mv /tmp/etcdctl /usr/local/bin/etcdctl \
  && rm /tmp/etcd-$ETCDCTL_VERSION.tar.gz \
  && go env -w GO111MODULE=on \
  && go env -w GOPROXY=https://goproxy.cn,direct \
  && go get -u -v \
    github.com/AlekSi/gocov-xml \
    github.com/axw/gocov/gocov \
    github.com/mitchellh/gox \
  && curl -sfL https://install.goreleaser.com/github.com/golangci/golangci-lint.sh | sh -s -- -b $GOPATH/bin $GOLANGCI_LINT_VERSION \
  && pip3 install --disable-pip-version-check --no-cache-dir azure-cli==${AZCLI_VERSION} shyaml \
  && apt-get purge --auto-remove -y libffi-dev python3-dev python3-pip \
  && apt-get autoremove -y \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man /usr/share/doc

WORKDIR /go

COPY . /
