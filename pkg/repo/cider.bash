#!/usr/bin/env bash

PKG_REPO="https://github.com/ciderapp/cider-releases"
PKG_NAME="cider"

true << EOF
DEB_DEPS wget curl libauthen-sasl-perl libclone-perl libdata-dump-perl libencode-locale-perl libfile-basedir-perl libfile-desktopentry-perl libfile-listing-perl libfile-mimeinfo-perl libfont-afm-perl libhtml-form-perl libhtml-format-perl libhtml-parser-perl libhtml-tagset-perl libhtml-tree-perl libhttp-cookies-perl libhttp-daemon-perl libhttp-date-perl libhttp-message-perl libhttp-negotiate-perl libio-html-perl libio-socket-ssl-perl libio-stringy-perl libipc-system-simple-perl liblwp-mediatypes-perl liblwp-protocol-https-perl libmailtools-perl libnet-dbus-perl libnet-http-perl libnet-smtp-ssl-perl libnet-ssleay-perl libnotify4 libsecret-1-0 libsecret-common libtie-ixhash-perl libtimedate-perl libtry-tiny-perl liburi-perl libwww-perl libwww-robotrules-perl libx11-protocol-perl libxml-parser-perl libxml-twig-perl libxml-xpathengine-perl perl-openssl-defaults xdg-utils
EOF

BUILD_DIR="pkg/src/$PKG_NAME"

function build() {
  printf "$PKG_NAME: working\n"

  cd $BUILD_DIR
  
  LVER="$(curl --silent --location --output /dev/null \
    --write-out "%{url_effective}\n" $PKG_REPO/releases/latest | cut -c58-)"
  
  if [ ! -e cider_"$LVER"_amd64.deb ]; then
    wget "$PKG_REPO"/releases/download/v"$LVER"/cider_"$LVER"_amd64.deb
  fi

  if sudo dpkg -i cider_"$LVER"_amd64.deb; then
    printf "$PKG_NAME: installed.\n"
  else
    printf "$PKG_NAME: failed to install.\n"
    exit
  fi
}

$1
