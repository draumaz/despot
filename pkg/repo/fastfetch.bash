#!/usr/bin/env bash

PKG_NAME="fastfetch"
PKG_REPO="https://github.com/LinusDierheimer/$PKG_NAME"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="cp fastfetch flashfetch /usr/local/bin/"
UNINSTALL_CMD=""
CLEAN_CMD="rm -rf build"

function build() {
    cd $BUILD_DIR
    mkdir -p build
    cd build
    echo "working on: $PKG_NAME"
    cmake .. > /dev/null 2>&1
    make > /dev/null 2>&1
    $INSTALL_CMD
    echo "installed."
    $CLEAN_CMD
}

$1
