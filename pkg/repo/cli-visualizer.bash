#!/usr/bin/env bash

PKG_NAME="cli-visualizer"
PKG_REPO="https://github.com/dpayne/$PKG_NAME"

DEB_DEPS="libfftw3-dev libncursesw5-dev libpulse-dev cmake"
RPM_DEPS="fftw-devel ncurses-devel pulseaudio-libs-devel cmake"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="bash install.sh"
UNINSTALL_CMD=""
CLEAN_CMD="rm -rf build/*"

function sources() {
  git clone $PKG_REPO $BUILD_DIR
}

function build() {
  if [ ! "$(grep -i debian /etc/os-release)" == "" ]; then echo $DEB_DEPS | xargs sudo apt-get install -y; fi
  if [ ! "$(grep -i fedora /etc/os-release)" == "" ]; then echo $RPM_DEPS | xargs sudo dnf install -y; fi
   
  echo "working on: $PKG_NAME"

  cd $BUILD_DIR
  mkdir -p build
  sudo $CLEAN_CMD
  
  sh configure > /dev/null 2>&1
  if sudo $INSTALL_CMD > /dev/null 2>&1; then
    echo "installed."
  else
    echo "failed to install."
    exit
  fi
  
  sudo $CLEAN_CMD
}

$1
