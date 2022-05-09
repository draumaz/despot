#!/usr/bin/env bash

PKG_NAME="stagit"
PKG_REPO="https://git.codemadness.org/$PKG_NAME"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="make install"
UNINSTALL_CMD="make uninstall"
CLEAN_CMD="rm -f stagit"

function sources() {
    git clone $PKG_REPO $BUILD_DIR
}

function uninstall() {
    cd $BUILD_DIR

    echo "uninstalling: $PKG_NAME"
    if sudo $UNINSTALL_CMD; then
        echo "uninstalled."
    else
        echo "failed to uninstall."
        exit
    fi
}

function build() {
    echo "working on: $PKG_NAME"
    
    cd $BUILD_DIR
    sudo $CLEAN_CMD

    if make > /dev/null 2>&1; then true; else
        echo "failed to compile."
        exit
    fi

    if sudo $INSTALL_CMD > /dev/null 2>&1; then
        echo "installed."
    else
        echo "failed to install."
        exit
    fi

    sudo $CLEAN_CMD
}

$1
