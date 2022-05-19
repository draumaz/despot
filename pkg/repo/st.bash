#!/usr/bin/env bash

PKG_REPO="https://git.suckless.org/st"
PKG_NAME="${PKG_REPO##*/}"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="make install"
UNINSTALL_CMD="make uninstall"
CLEAN_CMD="rm -f $PKG_NAME"

function sources() {
  git clone $PKG_REPO $BUILD_DIR
}

function uninstall() {
  cd $BUILD_DIR

  echo "uninstalling: $PKG_NAME"
  if sudo $UNINSTALL_CMD > /dev/null 2>&1; then
    echo "uninstalled."
  else
    echo "failed to uninstall."
    exit
  fi
}

function build() {
  cd $BUILD_DIR
  sudo $CLEAN_CMD

  echo -n "do you need to use a patchfile? [y/n]: "; read OPT0
  if [ "$OPT0" == "y" ]; then
    echo -n "file to patch: "; read PATCH_TARGET
    echo -n "patchfile path: "; read PATCH_PATH
    patch "$PATCH_TARGET" < "$PATCH_PATH"
  fi

  echo "working on: $PKG_NAME"

  if make > /dev/null 2>&1; then true; else
    echo "failed to compile."
    exit
  fi

  if sudo $INSTALL_CMD > /dev/null 2>&1; then
    echo "installed."
  else
    echo "failed to install."
    exit
  fi

  sudo $CLEAN_CMD
}

$1
