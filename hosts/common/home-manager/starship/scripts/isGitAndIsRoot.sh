#!/bin/bash
git rev-parse >/dev/null 2>&1 || exit 1

if [[ "$PWD" != *"$HOME"* ]]; then
    exit 0
fi

exit 1