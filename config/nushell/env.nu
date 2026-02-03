$env.config.buffer_editor = "subl"
$env.config.show_banner = false
$env.TRANSIENT_PROMPT_COMMAND = "❯ "
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense'
$env.EDITOR = "subl"

mkdir ~/.cache/carapace
carapace _carapace nushell | save --force ~/.cache/carapace/init.nu