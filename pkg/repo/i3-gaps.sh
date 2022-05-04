#!/bin/bash

PKG_NAME="i3-gaps"
PKG_REPO="https://github.com/Airblader/i3"

BUILD_DIR="$HOME/Builds/pkg/src/$PKG_NAME"
INSTALL_CMD="sudo ninja install"
CLEAN_CMD="sudo rm -rf build/*"

cd $BUILD_DIR
mkdir -p build

$CLEAN_CMD
cd build

echo "working on: $PKG_NAME"
meson .. > /dev/null 2>&1
$INSTALL_CMD > /dev/null 2>&1

cd ..; $CLEAN_CMD
