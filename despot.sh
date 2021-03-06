#!/bin/sh

# Copyright 2022 draumaz
# Distributed under the terms of the MIT license

case `id -u` in 1000) echo "run despot as superuser"; exit ;; esac

export DESPOT_VERSION="2022-07-22"
export BASE_DIR="/var/cache/despot"

RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
PURPLE=`tput setaf 5`
WHITE=`tput sgr0`

mkdir -p ${BASE_DIR}
test -e ${BASE_DIR}/repo/.git || git clone --quiet https://github.com/draumaz/despot-repo "${BASE_DIR}/repo"

# dbuild functions
pre_uninstall_checker() {
  test -e "$1" || die 1
}

basic_sources_setup() {
  test -e "$PKG_TARBALL" || curl --silent -fLO "$PKG_TARBALL_URL"
  tar -xpf "$PKG_TARBALL"
}

git_sources_setup() {
  git clone "$PKG_REPO" "${PKG_TITLE}-${PKG_VERSION}"
}

basic_environment_setup() {
  mkdir -p "$BASE_DIR"/work/"$PKG_TITLE"
  cd "$BASE_DIR"/work/"$PKG_TITLE"
  package_sources
  cd $PKG_EXTDIR
}

basic_environment_build_nest() {
  mkdir -p build
  cd build
}

basic_install_mini() {
  make install
}

basic_install() {
  make &&
  basic_install_mini &&
  cd ..
  rm -rf "$PKG_TITLE"
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

die() {
  case "$1" in
    1) echo "${RED}!!!!${WHITE}: package not installed"; exit ;;
    2) echo "${RED}!!!!${WHITE}: $2: missing dependency"; exit ;;
    3) echo "${RED}!!!!${WHITE}: argument missing"; exit ;;
    4) echo "${RED}!!!!${WHITE}: $2: no dbuild available"; exit ;;
    87) echo "${RED}!!!!${WHITE}: $PKG_TITLE: uninstall failed"; exit ;;
    88) echo "${RED}!!!!${WHITE}: $PKG_TITLE: install failed"; exit ;;
    99) exit ;;
  esac
}

deps() {
  echo "\n${GREEN}->${WHITE} checking dependencies"
  case `uname -s` in
    Linux)
      case `cat /etc/os-release` in
        *debian*) apt-get install -y `echo $DEB_DEPENDENCIES` ;;
        *fedora*) dnf install -y `echo $RPM_DEPENDENCIES` ;;
      esac ;;
    Darwin) test ! -e /usr/local/bin/brew || brew install `echo $MAC_DEPENDENCIES` ;; # doesn't work yet lol
  esac
  echo "${GREEN}->${WHITE} done\n"
}

preproc() {
  # determine what functions to use, else redirect to help screen
  test $1 && PKG_LOCK="$1" || PKG_LOCK="help"
  
  # meta text & updaters
  case "$PKG_LOCK" in
    help | h)
      cat << EOF
despot [arg] [...]
  
arguments:
${GREEN}->${WHITE} credits          | where it's due
${GREEN}->${WHITE} help             | you're here now
${GREEN}->${WHITE} install [pkgs]   | install packages
${GREEN}->${WHITE} observe          | list available dbuilds
${GREEN}->${WHITE} tug              | update repo database
${GREEN}->${WHITE} uninstall [pkgs] | uninstall packages
${GREEN}->${WHITE} version          | show current version
EOF
      die 99 
    ;;
    credits | c) cat << EOF
${GREEN}->${WHITE} despot $DESPOT_VERSION
${GREEN}->${WHITE} developed by draumaz
${GREEN}->${WHITE} named by DeltaDove
${GREEN}->${WHITE} MIT licensed software
EOF
      die 99
    ;;
    observe | o) for i in `find ${BASE_DIR}/repo/*/* -type f -name '*.dbuild' | cut -d '/' -f7 | cut -d '.' -f1`; do 
      echo "${GREEN}->${WHITE} $i"; done 
    ;;
    tug | t) cd "$BASE_DIR"/repo && git pull ;;
    selfupdate | s) 
      echo "${GREEN}->${WHITE} spinning up the updater"
      curl --silent https://raw.githubusercontent.com/draumaz/despot/master/bootstrap.sh | sh 
    ;;
    version | v) echo "${GREEN}->${WHITE} despot ${DESPOT_VERSION}"; die 99 ;;
  esac
}

rpck() {
  # determine repo, retrieve build functions
  case "$1" in install | uninstall | i | u)
    LIVE_REPO=`find $BASE_DIR/repo -type f -name '*.dbuild' | grep -i $2 | rev | cut -d / -f2 | rev`
    test -e "$BASE_DIR"/repo/"$LIVE_REPO"/"$2".dbuild || die 4 "$2"
    echo "${GREEN}->${WHITE} reading ${PURPLE}$2${WHITE} dbuild from ${YELLOW}${LIVE_REPO}${WHITE}"
    . "$BASE_DIR"/repo/${LIVE_REPO}/${2}.dbuild
  esac
}

bld() {
  # install processes
  case "$PKG_LOCK" in
    install | i)
      test ! -e "$DEB_DEPENDENCIES" || deps
      echo "${GREEN}->${WHITE} installing: $PKG_TITLE"; package_install
      echo "${GREEN}->${WHITE} installed : $PKG_TITLE" || die 88 ;;
    uninstall | u) 
      echo "\n${RED}->${WHITE} uninstalling: ${RED}$PKG_TITLE${WHITE}"; package_uninstall
      echo "${RED}->${WHITE} uninstalled:  ${RED}$PKG_TITLE${WHITE}" || die 87 ;;
  esac
}

preproc "$1"

for i in $@; do
  if test -z $e; then e="_" && continue; fi # block {,un}install argument from being read as a package
  rpck "$1" "$i" && bld
  rm -rf "$BASE_DIR"/work/"$PKG_TITLE"
  unset PKG_TITLE PKG_AUTHOR PKG_VERSION package_remove package_sources package_install
done
