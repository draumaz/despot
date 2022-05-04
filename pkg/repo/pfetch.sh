#!/usr/bin/env bash

PKG_NAME="pfetch"
PKG_REPO="https://github.com/dylanaraps/$PKG_NAME"

function build() {
    BUILD_DIR="$HOME/Builds/pkg/src/$PKG_NAME"
    INSTALL_CMD="sudo make install"
    cd $BUILD_DIR
    echo "working on: $PKG_NAME"
    $INSTALL_CMD > /dev/null 2>&1
}

$1