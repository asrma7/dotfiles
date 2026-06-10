use std/util "path add"


fnm env --json | from json | load-env
path add ($env.FNM_MULTISHELL_PATH + "/bin")

$env.PATH = ($env.PATH | uniq)
