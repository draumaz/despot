#!/usr/bin/env bash

PKG_NAME="st"
PKG_REPO="https://git.suckless.org/$PKG_NAME"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="make install"
UNINSTALL_CMD="make uninstall"
CLEAN_CMD="rm -f $PKG_NAME"

function uninstall() {
    cd $BUILD_DIR
    echo "uninstalling: $PKG_NAME"
    sudo $UNINSTALL_CMD
    echo "uninstalled."
}

function build() {
    cd $BUILD_DIR
    $CLEAN_CMD
    echo "working on: $PKG_NAME"
    make > /dev/null 2>&1
    sudo $INSTALL_CMD > /dev/null 2>&1
    echo "installed."
    $CLEAN_CMD
}

$1
