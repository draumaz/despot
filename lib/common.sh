#!/bin/sh

# Copyright 2022 draumaz
# Distributed under the terms of the MIT license

# A simple uninstaller. Two arguments; an existence checker
# and the list of files to remove.
# e.g. $ basic_uninstall "/bin/bash" "/lib/ncurses /usr/bin/cmake /home/gump/g++"

basic_uninstall() {
  test -e "$1" || die 1
  rm -rfv "$2"
}

basic_environment_setup() {
  mkdir -pv db/work/$PKG_TITLE && cd db/work/$PKG_TITLE
  sources_verify
  cd $PKG_TITLE
}

basic_environment_build_nest() {
  mkdir -pv build
  cd build
}

basic_install_mini() {
  make install
}

basic_install() {
  make &&
  basic_install_mini &&
  cd ..
  rm -rf $PKG_TITLE
}

basic_install_cmake() {
  cmake . &&
  basic_install
}
