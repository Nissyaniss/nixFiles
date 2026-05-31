#! /bin/bash

currentAbsoluteDirectory="$(pwd)"
home=$HOME
result="$(realpath -s --relative-to="${home}" "${currentAbsoluteDirectory}")"
echo "$result"