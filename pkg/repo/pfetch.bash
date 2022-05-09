#!/usr/bin/env bash

PKG_NAME="pfetch"
PKG_REPO="https://github.com/dylanaraps/$PKG_NAME"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="make install"
UNINSTALL_CMD="make uninstall"

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
    cd $BUILD_DIR

    echo "working on: $PKG_NAME"
    if $INSTALL_CMD > /dev/null 2>&1; then 
        echo "installed."
    else
        echo "failed to install."
}

$1
