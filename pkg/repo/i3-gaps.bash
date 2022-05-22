#!/usr/bin/env bash

PKG_REPO="https://github.com/Airblader/i3"
PKG_NAME="i3-gaps"

DEB_DEPS="gcc g++ meson dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="ninja install"
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
  
  if meson ..; then true; else
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
