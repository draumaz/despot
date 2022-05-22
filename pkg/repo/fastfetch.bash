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
  printf "${CLR_GREEN}working on: $PKG_NAME${CLR_NORM}\n"
  
  cd $BUILD_DIR
  mkdir -p build
  cd build
  
  if cmake ..; then true; else
    printf "${CLR_RED}failed to generate makefile.${CLR_NORM}\n"
    exit
  fi
  
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
