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
  sudo $CLEAN_CMD

  if make -{j,l}$(nproc); then true; else
    printf "failed to compile.\n"
    exit
  fi

  if sudo $INSTALL_CMD; then
    printf "installed.\n"
  else
    printf "failed to install.\n"
    exit
  fi
  
  sudo $CLEAN_CMD
}

$1
