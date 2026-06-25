#! /bin/bash

currentAbsoluteDirectory="$(pwd)"
result="$(realpath -s --relative-to="/" "${currentAbsoluteDirectory}")"
echo "$result"
