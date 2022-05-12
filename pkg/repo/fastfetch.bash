#!/usr/bin/env bash

PKG_NAME="fastfetch"
PKG_REPO="https://github.com/LinusDierheimer/$PKG_NAME"

#DEB_DEPS="cmake pkg-config"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="cp fastfetch flashfetch /usr/local/bin/"
UNINSTALL_CMD=""
CLEAN_CMD="rm -rf build"

function sources() {
    git clone $PKG_REPO $BUILD_DIR
}

function build() {
#    if [ ! "$(cat /etc/os-release | grep -i debian)" == ""]; then
#	    sudo apt-get install "$DEB_DEPS"
#    fi

    echo "working on: $PKG_NAME"
    
    cd $BUILD_DIR
    mkdir -p build
    cd build
    
    if cmake .. > /dev/null 2>&1; then true; else
        echo "failed to initialize."
        exit
    fi
    
    if make > /dev/null 2>&1; then true; else
        echo "failed to compile."
        exit
    fi

    if sudo $INSTALL_CMD; then
        echo "installed."
    else
        echo "failed to install."
        exit
    fi
    
    cd ..
    sudo $CLEAN_CMD
}

$1
