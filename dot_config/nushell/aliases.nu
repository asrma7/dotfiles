alias vim = nvim
alias vi = nvim
alias nano = nvim
alias nvc = chezmoi edit ~/.config/nvim/

alias catt = bat --paging=never

alias work = cd ~/projects

alias :q = exit

alias py = python3
alias nf = neofetch
alias c = clear
alias l = ls -l
alias la = ls -la
alias ll = ls -l
def l. [] { ls -all | where name starts-with "." | sort }
alias .. = cd ..

alias config = cd ~/.config

alias grep = grep --color=auto
alias sshk = kitty +kitten ssh

alias cp = cp -i
alias mv = mv -i
alias rm = rm -I

def dfl [] { df -h | ^column -t | from ssv }

def freel [] { free -h | ^column -t | from ssv }

alias df = df -h
alias free = free -h

def psmem [] { ps | sort-by mem --reverse | first 5 }

def pscpu [] { ps | sort-by cpu --reverse | first 5 }

alias lsservices = systemctl list-unit-files --state=enabled
alias lsinstalled = pacman -Q | fzf

alias gcl = gh repo clone
alias gpr = gh pr create
alias gprl = gh pr list

alias g = git
alias gs = git status
alias ga = git add
alias gc = git commit
alias gcm = git commit -m
alias gp = git push
alias gpl = git pull
alias gco = git checkout
alias gb = git branch
alias gr = git rebase

alias kc = kubectl

alias lg = lazygit
alias lsql = lazysql

alias oo = cd ~/obsidian-vault

alias asr = atuin scripts run
alias asl = atuin scripts list
alias asd = atuin scripts rm
alias ase = atuin scripts edit
alias asn = atuin scripts new

alias venv = sh -i -c 'source .venv/bin/activate ; nu'

alias ccu = chezmoi update
alias cca = chezmoi add
alias ccr = chezmoi forget
alias ccd = chezmoi cd
alias cce = chezmoi edit
alias ccs = chezmoi apply
