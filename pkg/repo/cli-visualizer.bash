#!/usr/bin/env bash

PKG_REPO="https://github.com/dpayne/cli-visualizer"
PKG_NAME="${PKG_REPO##*/}"

DEB_DEPS="libfftw3-dev libncursesw5-dev libpulse-dev cmake gcc g++"
RPM_DEPS="fftw-devel ncurses-devel pulseaudio-libs-devel cmake gcc g++"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="make install"
UNINSTALL_CMD=""
CLEAN_CMD="rm -rf CMakeFiles vis"

function sources() {
  git clone $PKG_REPO $BUILD_DIR
}

function build() {
  echo "working on: $PKG_NAME"
  cd $BUILD_DIR

  if cmake .; then true; else
    echo "failed to generate makefile."
    exit
  fi
  
  if make > /dev/null 2>&1; then true; else
    echo "failed to compile."
    exit
  fi

  if sudo $INSTALL_CMD; then
    echo "installed."
  else
    echo "failed to install."
    exit
  fi
  
  sudo $CLEAN_CMD
}

$1
