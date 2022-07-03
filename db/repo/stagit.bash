#!/usr/bin/env bash

PKG_REPO="git://git.codemadness.org/stagit"
PKG_NAME="${PKG_REPO##*/}"

true << EOF
DEB_DEPS libgit2-dev gcc make
EOF

BUILD_DIR="db/src/$PKG_NAME"
INSTALL_CMD="make install"
UNINSTALL_CMD="make uninstall"
CLEAN_CMD="rm -f stagit"

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

  if make -{j,l}$(nproc); then true; else
    printf "$PKG_NAME: failed to compile.\n"
    exit
  fi

  if $INSTALL_CMD; then
    printf "$PKG_NAME installed.\n"
  else
    printf "$PKG_NAME: failed to install.\n"
    exit
  fi
  
  $CLEAN_CMD
}

$1
