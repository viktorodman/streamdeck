#!/bin/sh
# Compile every non-probe *.applescript into a matching .app, baking in
# the absolute path to ./config.env wherever a __CONFIG_PATH__ placeholder appears.

set -e
cd "$(dirname "$0")"

CONFIG_PATH="$(pwd)/config.env"

for src in *.applescript; do
	case "$src" in probe-*) continue;; esac
	name=$(echo "${src%.applescript}" | awk -F- '{ for (i=1; i<=NF; i++) printf "%s", toupper(substr($i,1,1)) substr($i,2) }')
	out="${name}.app"

	tmp=$(mktemp -t streamdeck-build).applescript
	sed "s|__CONFIG_PATH__|${CONFIG_PATH}|g" "$src" > "$tmp"

	echo "  $src -> $out"
	osacompile -o "$out" "$tmp"
	rm "$tmp"
done
