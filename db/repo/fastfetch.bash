#!/usr/bin/env bash

PKG_REPO="https://github.com/LinusDierheimer/fastfetch"
PKG_NAME="${PKG_REPO##*/}"

true << EOF
DEB_DEPS gcc cmake make pkg-config
EOF

BUILD_DIR="db/src/$PKG_NAME"
INSTALL_CMD="cp -v fastfetch flashfetch /usr/local/bin/"
UNINSTALL_CMD=""
CLEAN_CMD="rm -rf build"

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

  if $INSTALL_CMD; then
    printf "$PKG_NAME: installed.\n"
  else
    printf "$PKG_NAME: failed to install.\n"
    exit
  fi
  
  cd ..
  
  $CLEAN_CMD
}

$1
