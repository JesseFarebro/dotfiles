set -Ux TERM alacritty

# Conform to XDG base spec
set -Ux XDG_DATA_HOME "$HOME/.local/share"
set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux XDG_CACHE_HOME "$HOME/.cache"
set -Ux XDG_RUNTIME_DIR $TMPDIR"runtime-$USER"

set -Ux N_PREFIX "$XDG_DATA_HOME"
set -Ux PYENV_ROOT "$XDG_DATA_HOME/pyenv"
set -Ux GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -Ux TMUX_TMPDIR "$XDG_RUNTIME_DIR"
set -Ux NVIM_LISTEN_ADDRESS "$XDG_RUNTIME_DIR/nvimsocket"
set -Ux NODE_REPL_HISTORY "$XDG_DATA_HOME/node_repl_history"
set -Ux NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/config"
set -Ux NPM_CONFIG_CACHE "$XDG_CACHE_HOME/npm"
set -Ux NPM_CONFIG_TMP "$XDG_RUNTIME_DIR/npm"
set -Ux DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -Ux TERMINFO "$XDG_DATA_HOME/terminfo"
set -Ux TERMINFO_DIRS "$XDG_DATA_HOME/terminfo:/usr/share/terminfo"
set -Ux IPYTHONDIR "$XDG_CONFIG_HOME/jupyter"
set -Ux JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME/jupyter"
set -Ux PYTHON_CONFIG "$XDG_CONFIG_HOME/python"
set -Ux MPLCONFIGDIR "$XDG_CONFIG_HOME/matplotlib"
set -Ux XAUTHORITY "$XDG_RUNTIME_DIR/Xauthority"
set -Ux PYTHONBREAKPOINT "ipdb.set_trace"
set -Ux TEXINPUTS ".:$XDG_DATA_HOME/texmf//:"
set -Ux PYLINTHOME "$XDG_CACHE_HOME/pylint"

set -Ux LESSHISTFILE -
set -Ux __CF_USER_TEXT_ENCODING 0x(id -u):0x0:0x52

set -U fish_user_paths \
	$HOME/.local/bin \
	$HOME/.local/share/bin \
	$PYENV_ROOT/bin \
	/usr/local/{bin,sbin}

# color scheme
set -U theme_color_scheme nord
set -Ux BAT_THEME "Nord"

# Source dir_colors if exists
if test -e $XDG_CONFIG_HOME/dircolors
    eval (gdircolors -c "$XDG_CONFIG_HOME/dircolors")
end

set -g EDITOR vim

# Aliases
alias ssh="env TERM=tmux-256color ssh"

alias rm="safe-rm"

alias dotfiles="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

alias vim="nvim"
alias vimdiff='nvim -d'

alias ls="exa --group-directories-first --color-scale --git"
alias cat="bat"

alias graq="ssh graham squeue -u $USER"
alias cdrq="ssh cedar squeue -u $USER"
alias blgq="ssh beluga squeue -u $USER"

# Command specific variables
set grc_wrap_commands diff tail gcc g++ ifconfig make mount ping ps tail df
set -Ux FZF_DEFAULT_COMMAND "rg --files --no-ignore --hidden --follow --glob '!.git/*'"

set -Ux PYTHONSTARTUP "$PYTHON_CONFIG/startup"
set -Ux PYTHON_CFLAGS "-I"(xcrun --show-sdk-path)"/usr/include"

# create XDG_RUNTIME_DIR on login
if status --is-login
    mkdir -p $XDG_RUNTIME_DIR
end

# Bootstrap session
if not functions -q fisher
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

if status --is-interactive
    type -q pyenv; and pyenv init - | source
    type -q pyenv; and pyenv virtualenv-init - | source
    starship init fish | source
    if not set -q TMUX; and type -q tmux
      exec tmux -2 new-session -A -s default
    end
end
