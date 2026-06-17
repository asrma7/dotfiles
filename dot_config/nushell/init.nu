$env.keybindings = $env.config.keybindings ++ [
  {
    name: reload_config
    modifier: alt
    keycode: char_r
    mode: [emacs, vi_normal, vi_insert]
    event: {
      send: executehostcommand,
      cmd: $"exec nu"
    }
  }
]

$env.table = ($env.config.table | merge {
  index_mode: "never"
})

$env.completions = ($env.config.completions | merge {
  case_sensitive: true
})

$env.config = ($env.config | merge {
  completions: $env.completions
  show_banner: false
  buffer_editor: "nvim"
  edit_mode: "vi"
  keybindings: $env.keybindings
  table: $env.table
})

source aliases.nu
source exports.nu
source functions.nu
