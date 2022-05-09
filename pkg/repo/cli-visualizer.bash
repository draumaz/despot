#!/usr/bin/env bash

PKG_NAME="cli-visualizer"
PKG_REPO="https://github.com/dpayne/$PKG_NAME"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="sh configure && bash install.sh"
UNINSTALL_CMD=""
CLEAN_CMD="rm -rf build/*"

function build() {
    BUILD_DIR="pkg/src/$PKG_NAME"
    CLEAN_CMD="rm -rf build/*"
    cd $BUILD_DIR
    mkdir -p build
    $CLEAN_CMD
    echo "working on: $PKG_NAME"
    $INSTALL_CMD > /dev/null 2>&1
    echo "installed."
    $CLEAN_CMD
}

$1
