#!/usr/bin/env bash

PKG_NAME="stagit"
PKG_REPO="https://git.codemadness.org/$PKG_NAME"

function build() {
    BUILD_DIR="pkg/src/$PKG_NAME"
    INSTALL_CMD="sudo make install"
    CLEAN_CMD="rm -f stagit"
    cd $BUILD_DIR
    $CLEAN_CMD
    echo "working on: $PKG_NAME"
    make > /dev/null 2>&1
    $INSTALL_CMD > /dev/null 2>&1
    $CLEAN_CMD
}

$1
