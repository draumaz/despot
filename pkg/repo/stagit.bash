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
  
  sudo $CLEAN_CMD
}

$1
