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
  printf "working on: $PKG_NAME\n"
  cd $BUILD_DIR

  if cmake .; then true; else
    printf "failed to generate makefile.\n"
    exit
  fi
  
  if make -{j,l}$(nproc); then true; else
    printf "failed to compile.\n"
    exit
  fi

  if sudo $INSTALL_CMD; then
    printf "installed.\n"
  else
    printf "failed to install.\n"
    exit
  fi
  
  sudo $CLEAN_CMD
}

$1
