#!/usr/bin/env bash

PKG_REPO="https://github.com/fairyglade/ly"
PKG_NAME="${PKG_REPO##*/}"

DEB_DEPS="build-essential libpam0g-dev libxcb-xkb-dev"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="make install"
UNINSTALL_CMD="make uninstall"
CLEAN_CMD="rm -rf bin obj"

function sources() {
  git clone --recursive $PKG_REPO $BUILD_DIR
}

function uninstall() {
  cd $BUILD_DIR

  echo "uninstalling: $PKG_NAME"
  if sudo $UNINSTALL_CMD; then
    echo "uninstalled."
  else
    echo "failed to uninstall."
    exit
  fi
}

function build() {
  echo "working on: $PKG_NAME"

  cd $BUILD_DIR
  sudo $CLEAN_CMD

  if make -{j,l}$(nproc); then true; else
    echo "failed to compile."
    exit
  fi

  if sudo $INSTALL_CMD; then
    echo "installed."
  else
    echo "failed to install."
    exit
  fi

  cd ..
  sudo $CLEAN_CMD
}

$1
