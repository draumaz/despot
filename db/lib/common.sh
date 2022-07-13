#!/bin/sh

# Copyright 2022 draumaz
# Distributed under the terms of the MIT license

basic_uninstall() {
  test -e "$1" || die 1
}

basic_sources_setup() {
  test -e $PKG_VERSION.tar.gz || curl -fLO "$PKG_TARBALL_URL"
  test -e "$PKG_TITLE-$PKG_VERSION" || tar -xpvf "$PKG_TARBALL"
}

basic_environment_setup() {
  mkdir -pv "$BASE_DIR"/work/$PKG_TITLE && cd "$BASE_DIR"/work/$PKG_TITLE
  package_sources
  cd $PKG_TITLE-$PKG_VERSION
}

basic_environment_build_nest() {
  mkdir -pv "$BASE_DIR"/"$PKG_TITLE-$PKG_VERSION"/build
  cd "$BASE_DIR"/"$PKG_TITLE-$PKG_VERSION"/build
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

basic_install_ninja() {
  meson .. &&
  ninja &&
  ninja install
}
