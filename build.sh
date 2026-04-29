#!/bin/sh
# Compile every *.applescript in this directory to a .app bundle.

set -e
cd "$(dirname "$0")"

for src in *.applescript; do
	case "$src" in probe-*) continue;; esac
	# connect-ipad.applescript -> ConnectIpad.app
	name=$(echo "${src%.applescript}" | awk -F- '{ for (i=1; i<=NF; i++) printf "%s", toupper(substr($i,1,1)) substr($i,2) }')
	out="${name}.app"
	echo "  $src -> $out"
	osacompile -o "$out" "$src"
done
