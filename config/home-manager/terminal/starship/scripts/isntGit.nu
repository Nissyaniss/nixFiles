#!/usr/bin/env nu

let pwd = pwd
let isAtHome = pwd | str contains $env.HOME

try {
	git rev-parse
} catch {
	if $pwd != $env.HOME and $isAtHome == true {
		exit 0
	}
}

exit 1
