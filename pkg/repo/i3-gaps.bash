#!/usr/bin/env bash

PKG_NAME="i3-gaps"
PKG_REPO="https://github.com/Airblader/i3"

DEB_DEPS="meson dh-autoreconf libxcb-keysyms1-dev \
  libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev \
  libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev \
  libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev \
  libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev \
  libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev"
  
RPM_DEPS="alsa-lib cairo dbus-libs flac-libs font-config \
  fonts-filesystem freetype fribidi gdk-pixbuf2 google-noto-fonts-common \
  google-noto-sans-vf-fonts graphite2 gsm harfbuzz i3status-config langpacks-core-font-en \
  libX11 libX11-common libX11-xcb libXau libXext libXft libXinerama libXrender libasyncns \
  libconfuse libdatrie libev libfontenc libjpeg-turbo libnl3 libogg libpng libptytty libsndfile \
  libthai libvorbis libxcb libxcbcommon libxcbcommon-x11 mkfontscale opus pango perl-AnyEvent \
  perl-AnyEvent-I3 perl-Filter perl-JSON-XS perl-Time-HiRes perl-Types-Serialiser perl-common-sense \
  perl-open pixman pulseaudio-libs shared-mime-info startup-notification xcb-util xcb-util-cursor \
  xcb-util-image xcb-util-keysyms xcb-util-renderutil xcb-util-wm xcb-util-xrm xml-common xorg-x11-fonts-misc yajl"

BUILD_DIR="pkg/src/$PKG_NAME"
INSTALL_CMD="ninja install"
UNINSTALL_CMD=""
CLEAN_CMD="rm -rf build"

function sources() {
  git clone $PKG_REPO $BUILD_DIR
}

function build() {
  if [ ! "$(grep -i debian /etc/os-release)" == "" ]; then echo $DEB_DEPS | xargs sudo apt-get install -y; fi
  if [ ! "$(grep -i fedora /etc/os-release)" == "" ]; then echo $RPM_DEPS | xargs sudo dnf install -y; fi

  echo "working on: $PKG_NAME"

  cd $BUILD_DIR
  mkdir -p build
  cd build
  
  if meson .. > /dev/null 2>&1; then true; else
    echo "failed to compile."
    exit
  fi
  
  if sudo $INSTALL_CMD > /dev/null 2>&1; then
    echo "installed."
  else
    echo "failed to install."
    exit
  fi
  
  cd ..
  sudo $CLEAN_CMD
}

$1
