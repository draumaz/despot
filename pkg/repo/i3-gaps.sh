#!/bin/bash

BUILD_DIR="$HOME/Builds/pkg/src/i3-gaps"
INSTALL_CMD="sudo ninja install"
CLEAN_CMD="sudo rm -rf build/*"

cd $BUILD_DIR
mkdir -p build

$CLEAN_CMD
cd build

echo "working on: i3-gaps"
meson .. > /dev/null 2>&1
$INSTALL_CMD > /dev/null 2>&1

cd ..; $CLEAN_CMD
