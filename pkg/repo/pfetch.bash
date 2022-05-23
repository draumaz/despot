#!/usr/bin/env bash

PKG_REPO="https://github.com/dylanaraps/pfetch"
PKG_NAME="${PKG_REPO##*/}"

# this package has no dependencies.

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="make install"
UNINSTALL_CMD="make uninstall"

function sources() {
  git clone $PKG_REPO $BUILD_DIR
}

function uninstall() {
  cd $BUILD_DIR

  printf "uninstalling: $PKG_NAME\n"
  if sudo $UNINSTALL_CMD; then
    printf "uninstalled.\n"
  else
    printf "failed to uninstall.\n"
    exit
  fi
}

function build() {
  printf "working on: $PKG_NAME\n"

  cd $BUILD_DIR
  
  if sudo $INSTALL_CMD; then 
    printf "installed.\n"
  else
    printf "failed to install.\n"
    exit
  fi
}

$1
