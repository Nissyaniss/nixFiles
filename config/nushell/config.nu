export def --env mkcd [name: path] {
  mkdir $name
  cd $name
}

$env.PATH = ($env.PATH | split row (char esep) | prepend "/home/nissya/.config/carapace/bin")

let carapace_completer = {|spans|
  # if the current command is an alias, get it's expansion
  let expanded_alias = (scope aliases | where name == $spans.0 | get 0 | get expansion)

# overwrite
let spans = (if $expanded_alias != null  {
  # put the first word of the expanded alias first in the span
  $spans | skip 1 | prepend ($expanded_alias | split row " " | take 1)
} else {
  $spans | skip 1 | prepend ($spans.0)
})

carapace $spans.0 nushell ...$spans
  | from json
}

mut current = (($env | default {} config).config | default {} completions)
$current.completions = ($current.completions | default {} external)
$current.completions.external = ($current.completions.external
| default true enable
| default { $carapace_completer } completer)

$current.render_right_prompt_on_last_line = true

$env.config = $current

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
source ~/.zoxide.nu
# source $"($nu.home-path)/.cargo/env.nu"