#!/usr/bin/env bash

PKG_REPO="https://github.com/Alcaro/Flips"
PKG_NAME="${PKG_REPO##*/}"

DEB_DEPS="g++ build-essential pkg-config libgtk-3-dev"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="cp -v flips /usr/local/bin/"
CLEAN_CMD="rm -rf flips"

function sources() {
  git clone $PKG_REPO $BUILD_DIR
}

function build() {
  printf "working on: $PKG_NAME\n"

  cd $BUILD_DIR
  bash make.sh
  
  if sudo $INSTALL_CMD; then 
    printf "installed.\n"
  else
    printf "failed to install.\n"
    exit
  fi

  sudo $CLEAN_CMD
}

$1
