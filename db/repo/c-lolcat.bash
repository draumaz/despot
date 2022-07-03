#!/usr/bin/env bash

PKG_REPO="https://github.com/draumaz/lolcat"
PKG_NAME="c-lolcat"

# this package has no dependencies.

BUILD_DIR="db/src/$PKG_NAME"

function uninstall() {
  cd $BUILD_DIR

  printf "$PKG_NAME: uninstalling"
  if make -{j,l}$(nproc) uninstall; then
    printf "$PKG_NAME: uninstalled.\n"
  else
    printf "$PKG_NAME: failed to uninstall.\n"
    exit
  fi
}

function build() {
  printf "$PKG_NAME: working\n"

  cd $BUILD_DIR
  
  if make -{j,l}$DTHREADS install; then 
    printf "$PKG_NAME: installed.\n"
  else
    printf "$PKG_NAME: failed to install.\n"
    exit
  fi
}

$1
