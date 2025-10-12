alias ls='ls --color=auto'
alias rm='rm -I'
alias pyvenv='python -m venv .venv'
alias srcvenv='source .venv/bin/activate'
alias pacinstall='sudo pacman -S'
alias pacuninstall='sudo pacman -Rns'
alias sysupdate='yay -Syu'
alias nv='nvim'
alias lsdir='du -hcs'
alias bk='popd'
alias hibernate='systemctl hibernate'
alias syssuspend='systemctl suspend'
alias tmux='tmux attach || tmux new -As0'
alias screen-sleep='sleep 1; xset dpms force off'
alias gvim='nvim --listen /tmp/nvimgodot'
alias rm='echo "use trash-put"; false'
alias tp='trash-put'

function ssht () {
    /usr/bin/ssh -t "$@" "tmux attach || tmux new";
}

function identify-key () {
    xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf "%-3s %s\n", $5, $8 }'
}
