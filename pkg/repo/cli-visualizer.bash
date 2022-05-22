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
  printf "${ENV_GREEN}working on: $PKG_NAME${ENV_NORM}\n"
  cd $BUILD_DIR

  if cmake .; then true; else
    printf "${ENV_RED}failed to generate makefile.${ENV_NORM}\n"
    exit
  fi
  
  if make -{j,l}$(nproc); then true; else
    printf "${ENV_RED}failed to compile.${ENV_NORM}\n"
    exit
  fi

  if sudo $INSTALL_CMD; then
    printf "${ENV_GREEN}installed.${ENV_NORM}\n"
  else
    printf "${ENV_RED}failed to install.${ENV_NORM}\n"
    exit
  fi
  
  sudo $CLEAN_CMD
}

$1
