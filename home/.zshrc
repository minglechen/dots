# Fedora has a different path for zsh
if [ -f /etc/fedora-release ]; then
    export FPATH=/usr/share/zsh/5.9/functions:$FPATH
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/mingle/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
autoload -Uz bashcompinit
bashcompinit

# startship init
eval "$(starship init zsh)"

# zoxide init
eval "$(zoxide init --cmd cd zsh)"

# Zplug init
if [ -f ${HOME}/.zplug/init.zsh ]; then
    source ${HOME}/.zplug/init.zsh
fi
zplug load


# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Accept zsh suggestion
bindkey '^Y' autosuggest-accept


# alias
alias proxy="http_proxy=socks5://localhost:12345 https_proxy=socks5://localhost:12345"
alias pacinstall="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacremove="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias yayremove="pacman -Qmq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias dragon="dragon-drop"
alias rm="rm -I"
alias n=y

# path
export PATH="$HOME/.local/bin:$HOME/.local/sbin:$PATH"

# fzf key bindings
if [ -f /etc/arch-release ]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

# yazi cd on quit
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# mosh morello via srcf
mosh-morello () {
    mosh -p 5123 --ssh="ssh -p 2222" mc2262@pip.srcf.net -- tmux a
}

# editor
export EDITOR=nvim

[ -f "/home/mingle/.ghcup/env" ] && source "/home/mingle/.ghcup/env" # ghcup-env

# ssh-agent
SSH_AUTH_SOCK=/run/user/1000/ssh-agent.socket; export SSH_AUTH_SOCK;
