#!/usr/bin/env bash

PKG_NAME="gummy"
PKG_REPO="https://github.com/Fushko/$PKG_NAME"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="make install"
UNINSTALL_CMD=""
CLEAN_CMD="rm -rf build"

function sources() {
    git clone $PKG_REPO $BUILD_DIR
}

function build() {
    echo "working on: $PKG_NAME"

    cd $BUILD_DIR
    mkdir -p build
    cd build

    if cmake .. \
        -DCMAKE_INSTALL_PREFIX=/usr \
        -DCMAKE_BUILD_TYPE="Release" \
        > /dev/null 2>&1; then true; else
            echo "failed to initialize."
            exit
    fi

    if cmake --build . > /dev/null 2>&1; then true; else
        echo "failed to compile"
        exit
    fi

    if sudo $INSTALL_CMD > /dev/null 2>&1; then
        echo "installed."
    else
        echo "failed to install."
        exit
    fi

    cd ..
    sudo $CLEAN_CMD
}

$1