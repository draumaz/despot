#!/bin/bash

BUILD_DIR="$HOME/Builds/pkg/src/pfetch"

INSTALL_CMD="sudo make install"

cd $BUILD_DIR

echo "compiling:  pfetch"
$INSTALL_CMD > /dev/null 2>&1
