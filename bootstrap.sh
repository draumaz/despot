#!/bin/sh
case "$(id -u)" in 1000) echo 'run me as root!' && exit ;; esac
echo "-> downloading despot" && curl --silent https://raw.githubusercontent.com/draumaz/despot/master/despot > despot.tmp
echo -n "-> installing... "
chmod -f +x despot.tmp
mv -f despot.tmp /usr/local/bin/despot
echo 'done.'
echo 'make sure /usr/local/bin is in your PATH.'
