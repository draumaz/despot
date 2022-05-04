#!/bin/bash

BUILD_DIR="$HOME/Builds/pkg/src/st"

INSTALL_CMD="sudo make install"
CLEAN_CMD="rm -f st"

cd $BUILD_DIR

$CLEAN_CMD

echo "working on: st"
make > /dev/null 2>&1
$INSTALL_CMD > /dev/null 2>&1

$CLEAN_CMD
