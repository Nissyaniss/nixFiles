#!/bin/bash
git rev-parse >/dev/null 2>&1 || exit 1
if [ "$(pwd)" = "$HOME" ]; then
	exit 0
elif [[ "$(pwd)" = "$HOME"/* ]]; then
	exit 0
else
	exit 1
fi
