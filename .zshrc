
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

# Zplug init
if [ -f ${HOME}/.zplug/init.zsh ]; then
    source ${HOME}/.zplug/init.zsh
fi
zplug load

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# nnn cd on quit
n()
{
    # Block nesting of nnn in subshells
    if [[ "${NNNLVL:-0}" -ge 1 ]]; then
	    echo "nnn is already running"
	    return
    fi
    # export to work on quit as well
    NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    \nnn -c -P p "$@"
    if [ -f "$NNN_TMPFILE" ]; then
	. "$NNN_TMPFILE"
	rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# thefuck aliases
eval "$(thefuck --alias)"

# alias
alias proxy="http_proxy=http://localhost:7890 https_proxy=http://localhost:7890"
alias pacinstall="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacremove="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias yayremove="pacman -Qmq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias dragon="dragon-drop"

# path
export PATH="$HOME/bin:$PATH"
export PATH=$PATH:~/.local/bin

# fzf key bindings
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# nnn 
export NNN_PLUG='p:preview-tui;o:fzopen;b:nbak;f:finder;v:imgview;k:kdeconnect;n:nuke;d:dragdrop;m:nmount'
export NNN_FIFO=/tmp/nnn.fifo
export EDITOR=nvim
export GUI=1
export NNN_OPENER="$HOME/.config/nnn/plugins/nuke"

[ -f "/home/mingle/.ghcup/env" ] && source "/home/mingle/.ghcup/env" # ghcup-env

# ssh-agent
SSH_AUTH_SOCK=/run/user/1000/ssh-agent.socket; export SSH_AUTH_SOCK;
