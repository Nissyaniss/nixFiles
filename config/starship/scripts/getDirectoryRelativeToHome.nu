#!/usr/bin/env nu

pwd | path relative-to ~ | prepend ~/ | str join ""
