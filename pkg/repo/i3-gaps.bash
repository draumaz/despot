#!/usr/bin/env bash

PKG_NAME="i3-gaps"
PKG_REPO="https://github.com/Airblader/i3"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="ninja install"
UNINSTALL_CMD=""
CLEAN_CMD="rm -rf build"

function build() {
    cd $BUILD_DIR
    mkdir -p build
    cd build
    echo "working on: $PKG_NAME"
    meson .. > /dev/null 2>&1
    sudo $INSTALL_CMD > /dev/null 2>&1
    echo "installed."
    cd ..
    $CLEAN_CMD
}

$1
