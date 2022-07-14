#!/bin/sh
case "$(id -u)" in 1000) echo 'run me as root!'; exit ;; esac
curl -fLO https://raw.githubusercontent.com/draumaz/despot/trunk/despot
chmod +x despot
mv -vf despot /usr/local/bin
echo 'make sure /usr/local/bin is in your PATH.'
