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

  printf "${CLR_GREEN}uninstalling: $PKG_NAME${CLR_NORM}\n"
  if sudo $UNINSTALL_CMD; then
    printf "${CLR_GREEN}uninstalled.${CLR_NORM}\n"
  else
    printf "${CLR_RED}failed to uninstall.${CLR_NORM}\n"
    exit
  fi
}

function build() {
  printf "${CLR_GREEN}working on: $PKG_NAME${CLR_NORM}\n"

  cd $BUILD_DIR
  sudo $CLEAN_CMD

  if make -{j,l}$(nproc); then true; else
    printf "${CLR_RED}failed to compile.${CLR_NORM}\n"
    exit
  fi

  if sudo $INSTALL_CMD; then
    printf "${CLR_GREEN}installed.${CLR_NORM}\n"
  else
    printf "${CLR_RED}failed to install.${CLR_NORM}\n"
    exit
  fi

  cd ..
  sudo $CLEAN_CMD
}

$1
