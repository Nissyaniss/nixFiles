#!/usr/bin/env nu

let isAtHome = pwd | str contains $env.HOME
try {
	git rev-parse
} catch {
	exit 1
}

if $isAtHome == false {
	exit 0
} 

exit 1
