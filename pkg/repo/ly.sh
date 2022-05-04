#!/bin/bash

BUILD_DIR="$HOME/Builds/pkg/src/ly"

INSTALL_CMD="sudo make install"
CLEAN_CMD="rm -rf bin obj"

cd $BUILD_DIR

$CLEAN_CMD

echo "working on: ly"
make > /dev/null 2>&1
$INSTALL_CMD > /dev/null 2>&1

$CLEAN_CMD
