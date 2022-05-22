#!/usr/bin/env bash

PKG_REPO="https://github.com/LinusDierheimer/fastfetch"
PKG_NAME="${PKG_REPO##*/}"

DEB_DEPS="gcc cmake pkg-config"
RPM_DEPS="gcc cmake pkgconf-pkg-config"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="cp -v fastfetch flashfetch /usr/local/bin/"
UNINSTALL_CMD=""
CLEAN_CMD="rm -rf build"

function sources() {
  git clone $PKG_REPO $BUILD_DIR
}

function build() {
  echo "working on: $PKG_NAME"
  
  cd $BUILD_DIR
  mkdir -p build
  cd build
  
  if cmake ..; then true; else
    echo "failed to generate makefile."
    exit
  fi
  
  if make -{j,l}$(nproc); then true; else
    echo "failed to compile."
    exit
  fi

  if sudo $INSTALL_CMD; then
    echo "installed."
  else
    echo "failed to install."
    exit
  fi
  
  cd ..
  sudo $CLEAN_CMD
}

$1
