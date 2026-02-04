#! /bin/bash

currentAbsoluteDirectory="$(pwd)"
result="$(realpath -s --relative-to="/home/nissya" "${currentAbsoluteDirectory}")"
echo "$result"