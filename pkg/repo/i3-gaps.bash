#!/usr/bin/env bash

PKG_NAME="i3-gaps"
PKG_REPO="https://github.com/Airblader/i3"

function build() {
    BUILD_DIR="pkg/src/$PKG_NAME"
    INSTALL_CMD="sudo ninja install" # find an alternate way to gain superuser.
    CLEAN_CMD="sudo rm -rf build/*"
    cd $BUILD_DIR
    mkdir -p build
    $CLEAN_CMD
    cd build
    echo "working on: $PKG_NAME"
    meson .. > /dev/null 2>&1
    $INSTALL_CMD > /dev/null 2>&1
    cd ..; $CLEAN_CMD
}

$1
