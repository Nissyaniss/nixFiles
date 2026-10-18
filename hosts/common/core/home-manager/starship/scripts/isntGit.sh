#!/bin/bash

if ! git rev-parse >/dev/null 2>&1; then
	if [[ "$PWD" != "$HOME" ]] && [[ "$PWD" == *"$HOME"* ]]; then
		exit 0
	fi
fi

exit 1
