#!/usr/bin/env bash

PKG_NAME="ly"
PKG_REPO="https://github.com/fairyglade/$PKG_NAME"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="make install"
UNINSTALL_CMD="make uninstall"
CLEAN_CMD="rm -rf bin obj"

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
