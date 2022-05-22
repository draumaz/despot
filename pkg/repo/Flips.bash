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
  printf "${ENV_GREEN}working on: $PKG_NAME${ENV_NORM}\n"

  cd $BUILD_DIR
  bash make.sh
  
  if sudo $INSTALL_CMD; then 
    printf "${ENV_GREEN}installed.${ENV_NORM}\n"
  else
    printf "${ENV_RED}failed to install.${ENV_NORM}\n"
    exit
  fi

  sudo $CLEAN_CMD
}

$1
