#!/usr/bin/env bash

PKG_REPO="https://github.com/dylanaraps/pfetch"
PKG_NAME="${PKG_REPO##*/}"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="make install"
UNINSTALL_CMD="make uninstall"

function sources() {
  git clone $PKG_REPO $BUILD_DIR
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
  
  if sudo $INSTALL_CMD; then 
    printf "${CLR_GREEN}installed.${CLR_NORM}\n"
  else
    printf "${CLR_RED}failed to install.${CLR_NORM}\n"
    exit
  fi
}

$1
