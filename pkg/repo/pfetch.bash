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

  printf "${ENV_GREEN}uninstalling: $PKG_NAME${ENV_NORM}\n"
  if sudo $UNINSTALL_CMD; then
    printf "${ENV_GREEN}uninstalled.${ENV_NORM}\n"
  else
    printf "${ENV_RED}failed to uninstall.${ENV_NORM}\n"
    exit
  fi
}

function build() {
  printf "${ENV_GREEN}working on: $PKG_NAME${ENV_NORM}\n"

  cd $BUILD_DIR
  
  if sudo $INSTALL_CMD; then 
    printf "${ENV_GREEN}installed.${ENV_NORM}\n"
  else
    printf "${ENV_RED}failed to install.${ENV_NORM}\n"
    exit
  fi
}

$1
