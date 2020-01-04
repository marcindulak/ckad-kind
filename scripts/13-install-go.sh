#!/bin/bash
# curl https://gist.githubusercontent.com/jeremyje/6b4cb25cdfe6fe09e13d441428e63c59/raw/install-go.sh | bash
# https://golang.org/dl/
LATEST_GO_VERSION=1.13.5
PrepareInstallation() {
  sudo apt-get -qq -y update
  sudo apt-get -qq -y install cmake build-essential git autoconf automake \
    libtool curl build-essential
  echo "end"
}

InstallGolang () {
  echo "start1"
  export GOPATH=${HOME}/go
  GO_PACKAGE=go${LATEST_GO_VERSION}.linux-amd64.tar.gz
  
  mkdir -p ${GOPATH}
  ls -al $HOME
  ls -al /usr/local/go
  go version
  which go
  sudo rm -rf /usr/local/go/
  ls -al /usr/local/go
  echo "start2"
  curl https://storage.googleapis.com/golang/${GO_PACKAGE} | sudo tar -C /usr/local -xz
  ls -al /usr/local/go
  sudo sh -c "echo 'export GOPATH=$GOPATH' >> /etc/profile"
  sudo sh -c "echo 'export PATH=/usr/local/go/bin:${GOPATH}/bin:$PATH' >> /etc/profile"
  sudo sh -c "echo 'export GOROOT=/usr/local/go' >> /etc/profile"
  echo "start3"

  export GOPATH=$GOPATH
  export PATH=/usr/local/go/bin:${GOPATH}/bin:$PATH
  export GOROOT=/usr/local/go
}

Main() {
  PrepareInstallation
  InstallGolang
}

Main
