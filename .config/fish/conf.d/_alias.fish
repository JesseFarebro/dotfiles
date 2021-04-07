alias ssh="env TERM=tmux-256color ssh"
alias rm="safe-rm"

alias dotfiles="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

alias vim="nvim"
alias vimdiff='nvim -d'

alias ls="exa --group-directories-first --color-scale --icons --git"
alias cat="bat"

alias R="R --no-save"

alias graq="ssh graham squeue -u $USER"
alias cdrq="ssh cedar squeue -u $USER"
alias blgq="ssh beluga squeue -u $USER"
