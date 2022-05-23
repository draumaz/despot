#!/usr/bin/env bash

PKG_REPO="https://github.com/LinusDierheimer/fastfetch"
PKG_NAME="${PKG_REPO##*/}"

DEB_DEPS="gcc cmake make pkg-config"
RPM_DEPS="gcc cmake make pkgconf-pkg-config"
ARCH_DEPS="gcc cmake make pkgconf"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="cp -v fastfetch flashfetch /usr/local/bin/"
UNINSTALL_CMD=""
CLEAN_CMD="rm -rf build"

function sources() {
  git clone $PKG_REPO $BUILD_DIR
}

function build() {
  printf "$PKG_NAME: working\n"
  
  cd $BUILD_DIR
  mkdir -p build
  cd build
  
  if cmake ..; then true; else
    printf "$PKG_NAME: failed to generate makefile.\n"
    exit
  fi
  
  if make -{j,l}$(nproc); then true; else
    printf "$PKG_NAME: failed to compile.\n"
    exit
  fi

  if sudo $INSTALL_CMD; then
    printf "$PKG_NAME: installed.\n"
  else
    printf "$PKG_NAME: failed to install.\n"
    exit
  fi
  
  cd ..
  sudo $CLEAN_CMD
}

$1
