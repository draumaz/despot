#!/usr/bin/env bash

PKG_REPO="https://github.com/Duncaen/OpenDoas"
PKG_NAME="opendoas-sudo"

true << EOF
DEB_DEPS doas
EOF

export DOAS_PATH="$(whereis doas | awk '{print $2}' | sed 's/doas//g')"

function uninstall() {
  cd $BUILD_DIR

  printf "$PKG_NAME: uninstalling\n"
  if rm -fv "$DOAS_PATH"sudo; then
    printf "$PKG_NAME: uninstalled.\n"
  else
    printf "$PKG_NAME: failed to uninstall.\n"
    exit
  fi
}

function build() {
  printf "$PKG_NAME: working\n"
  
  if ln -sv "$DOAS_PATH"doas "$DOAS_PATH"sudo; then 
    printf "$PKG_NAME: installed.\n"
  else
    printf "$PKG_NAME: failed to install.\n"
    exit
  fi
}

$1
