#!/usr/bin/env bash

PKG_LIST=$(ls pkg/src | tr " " "\n")

case "$1" in
	"list")
		echo "$PKG_LIST"
		;;
	"update")
		for l in $PKG_LIST; do
			cd pkg/src/$l
			echo "$l:"
			git pull
			echo ""
			cd ../../..
		done
		;;
	"upgrade")
		for l in $PKG_LIST; do
			bash pkg/repo/${l}.sh
		done
		;;
	*)
		echo "unrecognized command"
		;;
esac
