#!/bin/bash
git rev-parse
if [ "$?" = 0 ]; then
	exit 0
elif [ "$(pwd)" = "$HOME" ]; then
	exit 1
else
	exit 1
fi
