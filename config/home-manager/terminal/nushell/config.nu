export def --env mkcd [name: path] {
  mkdir $name
  cd $name
}

$env.config.render_right_prompt_on_last_line = true

# Home Manager will handle starship and carapace integration