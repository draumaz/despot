#!/usr/bin/env bash

PKG_NAME="st"
PKG_REPO="https://git.suckless.org/$PKG_NAME"

function build() {
    BUILD_DIR="$HOME/Builds/pkg/src/$PKG_NAME"
    INSTALL_CMD="sudo make install"
    CLEAN_CMD="rm -f st"
    cd $BUILD_DIR
    $CLEAN_CMD
    echo "working on: $PKG_NAME"
    make > /dev/null 2>&1
    $INSTALL_CMD > /dev/null 2>&1
    $CLEAN_CMD
}

$1