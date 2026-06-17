$env.keybindings = $env.config.keybindings ++ [
  {
    name: reload_config
    modifier: control
    keycode: char_g
    mode: [emacs, vi_normal, vi_insert]
    event: {
      send: executehostcommand,
      cmd: $" exec nu"
    }
  },
  {
    name: disable_history
    modifier: control
    keycode: char_f
    mode: [emacs, vi_normal, vi_insert]
    event: {
      send: executehostcommand,
      cmd: $" exec nu --no-history"
    }
  }
]

