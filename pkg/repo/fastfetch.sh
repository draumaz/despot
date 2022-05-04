#!/bin/bash

BUILD_DIR="$HOME/Builds/pkg/src/fastfetch"
INSTALL_CMD="cp fastfetch flashfetch $HOME/.local/bin/"
CLEAN_CMD="rm -rf build/*"

cd $BUILD_DIR
mkdir -p build

$CLEAN_CMD
cd build

echo "compiling:  fastfetch"
cmake .. > /dev/null 2>&1
make > /dev/null 2>&1
$INSTALL_CMD

$CLEAN_CMD
