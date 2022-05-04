#!/bin/bash

BUILD_DIR="$HOME/Builds/pkg/src/cli-visualizer"
CLEAN_CMD="rm -rf build/*"

cd $BUILD_DIR
mkdir -p build

$CLEAN_CMD

echo "compiling:  cli-visualizer"
sh configure
bash install.sh > /dev/null 2>&1

$CLEAN_CMD
