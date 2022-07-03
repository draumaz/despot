#!/usr/bin/env bash

PKG_REPO="https://github.com/ciderapp/cider-releases"
PKG_NAME="cider"

# this package has no dependencies.

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="dpkg -i cider_"$LVER"_amd64.deb"


function build() {
  printf "$PKG_NAME: working\n"

  cd $BUILD_DIR
  
  LVER="$(curl --silent --location --output /dev/null \
    --write-out "%{url_effective}\n" $PKG_REPO/releases/latest | cut -c58-)"

  wget "$PKG_REPO"/releases/download/v"$LVER"/cider_"$LVER"_amd64.deb

  if sudo $INSTALL_CMD; then
    printf "$PKG_NAME: installed.\n"
  else
    printf "$PKG_NAME: failed to install.\n"
    exit
  fi
}

$1
