#!/usr/bin/env nu

let pwd = pwd

try {
	git rev-parse
} catch {
	if $pwd == $env.HOME {
		exit 0
	}
}

exit 1
