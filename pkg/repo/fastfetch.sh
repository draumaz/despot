#!/usr/bin/env bash

PKG_NAME="fastfetch"
PKG_REPO="https://github.com/LinusDierheimer/$PKG_NAME"

function build() {
    BUILD_DIR="$HOME/Builds/pkg/src/$PKG_NAME"
    INSTALL_CMD="cp fastfetch flashfetch $HOME/.local/bin/"
    CLEAN_CMD="rm -rf build/*"
    cd $BUILD_DIR
    mkdir -p build
    $CLEAN_CMD
    cd build
    echo "working on: $PKG_NAME"
    cmake .. > /dev/null 2>&1
    make > /dev/null 2>&1
    $INSTALL_CMD
    $CLEAN_CMD
}

$1