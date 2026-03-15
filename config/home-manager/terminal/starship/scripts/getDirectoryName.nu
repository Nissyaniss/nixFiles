#!/usr/bin/env nu

let currentAbsoluteDirectory = pwd
let result = realpath -s --relative-to="/home/nissya" $currentAbsoluteDirectory
print $result