#!/bin/sh
case "$(id -u)" in 1000) echo 'run me as root!' && exit ;; esac
echo "-> downloading despot binary"
curl --silent https://raw.githubusercontent.com/draumaz/despot/master/despot > despot.tmp
echo "-> making binary executable"
chmod +x despot.tmp
mv -vf despot.tmp /usr/local/bin/despot
echo '!! make sure /usr/local/bin is in your PATH.'
