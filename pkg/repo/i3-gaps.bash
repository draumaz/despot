#!/usr/bin/env bash

PKG_REPO="https://github.com/Airblader/i3"
PKG_NAME="i3-gaps"

DEB_DEPS="meson dh-autoreconf libxcb-keysyms1-dev \
  libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev \
  libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev \
  libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev \
  libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev \
  libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="ninja install"
UNINSTALL_CMD=""
CLEAN_CMD="rm -rf build"

function sources() {
  git clone $PKG_REPO $BUILD_DIR
}

function build() {
  if [ ! "$(grep -i debian /etc/os-release)" == "" ]; then echo $DEB_DEPS | xargs sudo apt-get install -y; fi

  echo "working on: $PKG_NAME"

  cd $BUILD_DIR
  mkdir -p build
  cd build
  
  if meson .. > /dev/null 2>&1; then true; else
    echo "failed to compile."
    exit
  fi
  
  if sudo $INSTALL_CMD > /dev/null 2>&1; then
    echo "installed."
  else
    echo "failed to install."
    exit
  fi
  
  cd ..
  sudo $CLEAN_CMD
}

$1
