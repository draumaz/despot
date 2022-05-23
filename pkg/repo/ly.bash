#!/usr/bin/env bash

PKG_REPO="https://github.com/fairyglade/ly"
PKG_NAME="${PKG_REPO##*/}"

DEB_DEPS="build-essential libpam0g-dev libxcb-xkb-dev"
ARCH_DEPS="pam libxcb"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="make install"
UNINSTALL_CMD="make uninstall"
CLEAN_CMD="rm -rf bin obj"

function sources() {
  git clone --recursive $PKG_REPO $BUILD_DIR
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

  cd ..
  sudo $CLEAN_CMD
}

$1
