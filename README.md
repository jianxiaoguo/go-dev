# drycc/go-dev

A [Go][] language development toolbox.

Many [Drycc Workflow][] components use this Container image as a standard build and test environment,
but it is intended to be useful to any Go developer. Please help make drycc/go-dev better by
creating [issues][] and submitting [pull requests][].

## Image Contents

* [az][]: Azure cloud command-line tool
* [azcopy][]: Utility for copying data to/from Microsoft Azure Blob and File storage
* [dep][]: Go dependency management tool
* [delve][]: debugger for the Go programming language
* [gb][]: project-based build tool for Go
* [ginkgo][]: BDD testing framework for Go
* [glide][]: Go dependency management tool
* [go-bindata][]: converts any file into Go source code
* [golint][]: Go source code linter
* [gometalinter][]: run Go lint tools concurrently
* [golangci-lint][]: concurrent runner for Go linting tools
* [gox][]: simple Go cross-compiling tool
* [helm][]: Kubernetes package manager
* [jq][]: command-line JSON processor
* [jwt][]: tool for creating and parsing JSON Web Tokens
* [k][]: automatically run the correct version of `kubectl` every time
* [kubectl][]: Kubernetes command-line client
* [Packer][]: build automated machine images
* [ruby][]: ruby scripting language
* [shellcheck][]: static analysis for shell scripts
* [shyaml][]: YAML access from the command line
* [test-cover.sh][]: test coverage for multiple Go packages
* [unzip][]: list, test, and extract files from ZIP archives
* [upx][]: executable packer
* [vim][]: text editor

## Usage

Mount your local Go code into a container's `$GOPATH` to run any `go` command or one of the
included tools or scripts. Here's an example of running `go build` for drycc/builder:

```console
$ podman run --rm \
  --volume $GOPATH/src/github.com/drycc/builder:/go/src/github.com/drycc/builder \
  --workdir /go/src/github.com/drycc/builder \
  registry.drycc.cc/drycc/go-dev \
  go build
```

The latest registry.drycc.cc/drycc/go-dev Container image is available at:

* [Drycc Registry][]
  ```
  podman pull registry.drycc.cc/drycc/go-dev
  ```

[az]: https://github.com/Azure/azure-cli#readme
[azcopy]: https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-linux?toc=%2fazure%2fstorage%2ffiles%2ftoc.json
[Drycc Workflow]: https://drycc.com/
[delve]: https://github.com/derekparker/delve
[dep]: https://github.com/golang/dep
[gb]: https://github.com/constabulary/gb/
[gen-changelog.sh]: https://github.com/drycc/go-dev/tree/main/rootfs/usr/local/bin/gen-changelog.sh
[ginkgo]: https://github.com/onsi/ginkgo
[glide]: https://github.com/Masterminds/glide
[go-bindata]: https://github.com/jteeuwen/go-bindata
[Go]: https://golang.org/
[golint]: https://github.com/golang/lint
[gometalinter]: https://github.com/alecthomas/gometalinter
[golangci-lint]: https://github.com/golangci/golangci-lint
[gox]: https://github.com/mitchellh/gox
[helm]: https://github.com/kubernetes/helm
[issues]: https://github.com/drycc/go-dev/issues
[jq]: https://stedolan.github.io/jq/
[jwt]: https://github.com/dgrijalva/jwt-go
[k]: https://github.com/jakepearson/k
[kubectl]: https://kubernetes.io/docs/user-guide/kubectl-overview/
[pull requests]: https://github.com/drycc/go-dev/pulls
[Packer]: https://github.com/hashicorp/packer
[ruby]: https://www.ruby-lang.org/
[shellcheck]: https://github.com/koalaman/shellcheck
[shyaml]: https://github.com/0k/shyaml
[test-cover.sh]: https://github.com/drycc/go-dev/tree/main/rootfs/usr/local/bin/test-cover.sh
[unzip]: https://linux.die.net/man/1/unzip
[upx]: http://upx.sourceforge.net/
[vim]: http://www.vim.org/
[ruby]: https://www.ruby-lang.org/
