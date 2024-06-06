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


# alias
alias proxy="http_proxy=socks5://localhost:12345 https_proxy=socks5://localhost:12345"
alias pacinstall="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacremove="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias yayremove="pacman -Qmq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias dragon="dragon-drop"
alias rm="rm -I"

# path
export PATH="$HOME/.local/bin:$PATH"

# fzf key bindings
if [ -f /etc/arch-release ]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
fi

# nnn 
# nnn cd on quit
n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn -a -P p "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f "$NNN_TMPFILE" > /dev/null
    }
}
export NNN_BMS='d:~/Downloads;p:~/Phone Download'
export NNN_PLUG='p:preview-tui;o:fzopen;b:nbak;f:finder;v:imgview;k:kdeconnect;n:nuke;d:dragdrop;m:nmount'
# export NNN_FIFO=/tmp/nnn.fifo
export EDITOR=nvim
export GUI=1
export NNN_OPENER="$HOME/.config/nnn/plugins/nuke"
export NNN_ICONLOOKUP=1

[ -f "/home/mingle/.ghcup/env" ] && source "/home/mingle/.ghcup/env" # ghcup-env

# ssh-agent
SSH_AUTH_SOCK=/run/user/1000/ssh-agent.socket; export SSH_AUTH_SOCK;

# docker
alias docker=podman
