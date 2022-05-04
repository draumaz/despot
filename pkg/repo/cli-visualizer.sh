#!/bin/bash

PKG_NAME="cli-visualizer"
PKG_REPO="https://github.com/dpayne/$PKG_NAME"

BUILD_DIR="$HOME/Builds/pkg/src/$PKG_NAME"
CLEAN_CMD="rm -rf build/*"

cd $BUILD_DIR
mkdir -p build

$CLEAN_CMD

echo "working on: $PKG_NAME"
sh configure
bash install.sh > /dev/null 2>&1

$CLEAN_CMD
