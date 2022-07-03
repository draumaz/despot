#!/usr/bin/env bash

PKG_REPO="https://git.suckless.org/st"
PKG_NAME="${PKG_REPO##*/}"

# this package has no dependencies.

BUILD_DIR="db/src/$PKG_NAME"
INSTALL_CMD="make install"
UNINSTALL_CMD="make uninstall"
CLEAN_CMD="rm -f $PKG_NAME"

function uninstall() {
  cd $BUILD_DIR

  printf "$PKG_NAME: uninstalling\n"
  if $UNINSTALL_CMD; then
    printf "$PKG_NAME: uninstalled.\n"
  else
    printf "$PKG_NAME: failed to uninstall.\n"
    exit
  fi
}

function build() {
  printf "$PKG_NAME: working\n"

  cd $BUILD_DIR
  $CLEAN_CMD

  echo -n "$PKG_NAME: do you need to use a patchfile? [y/n]: "; read OPT0
  if [ "$OPT0" == "y" ]; then
    echo -n "$PKG_NAME: file to patch: "; read PATCH_TARGET
    echo -n "$PKG_NAME: patchfile path: "; read PATCH_PATH
    patch "$PATCH_TARGET" < "$PATCH_PATH"
  fi

  if make -{j,l}$DTHREADS; then true; else
    printf "$PKG_NAME: failed to compile.\n"
    exit
  fi

  if $INSTALL_CMD; then
    printf "$PKG_NAME: installed.\n"
  else
    printf "$PKG_NAME: failed to install.\n"
    exit
  fi

  $CLEAN_CMD
}

$1
