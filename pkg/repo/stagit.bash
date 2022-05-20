#!/usr/bin/env bash

PKG_REPO="git://git.codemadness.org/stagit"
PKG_NAME="${PKG_REPO##*/}"

DEB_DEPS="libgit2-dev"
RPM_DEPS="libgit2-devel"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="make install"
UNINSTALL_CMD="make uninstall"
CLEAN_CMD="rm -f stagit"

function sources() {
  git clone $PKG_REPO $BUILD_DIR
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

  if make; then true; else
    echo "failed to compile."
    exit
  fi

  if sudo $INSTALL_CMD; then
    echo "installed."
  else
    echo "failed to install."
    exit
  fi
  
  sudo $CLEAN_CMD
}

$1
