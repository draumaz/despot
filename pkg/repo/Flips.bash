#!/usr/bin/env bash

PKG_REPO="https://github.com/Alcaro/Flips"
PKG_NAME="${PKG_REPO##*/}"

true << EOF
DEB_DEPS g++ pkg-config build-essential
EOF

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="cp -v flips /usr/local/bin/"
CLEAN_CMD="rm -rf flips"

function build() {
  printf "$PKG_NAME: working\n"

  cd $BUILD_DIR
  bash make.sh
  
  if $INSTALL_CMD; then 
    printf "$PKG_NAME: installed.\n"
  else
    printf "$PKG_NAME: failed to install.\n"
    exit
  fi

  sudo $CLEAN_CMD
}

$1
