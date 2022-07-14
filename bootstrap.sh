#!/bin/sh
case "$(id -u)" in 1000) echo 'run me as root!'; exit ;; esac
curl -fLO https://raw.githubusercontent.com/draumaz/despot/trunk/despot
chmod +x despot.tmp
mv -vf despot.tmp /usr/local/bin/despot
echo 'make sure /usr/local/bin is in your PATH.'
