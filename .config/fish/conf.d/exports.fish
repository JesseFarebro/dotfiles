# Fish
set -U fish_greeting

# XDG
set -Ux XDG_DATA_HOME "$HOME/.local/share"
set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux XDG_CACHE_HOME "$HOME/.cache"
set -Ux XDG_RUNTIME_DIR $TMPDIR"runtime-$USER"

# create XDG_RUNTIME_DIR on login
if status --is-login
    mkdir -p $XDG_RUNTIME_DIR
end

# ncurses
set -gx TERMINFO "$XDG_DATA_HOME/terminfo"
set -gx TERMINFO_DIRS "$XDG_DATA_HOME/terminfo:/usr/share/terminfo"

# Node
set -gx NODE_REPL_HISTORY "$XDG_DATA_HOME/node_repl_history"
set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/config"
set -gx NPM_CONFIG_CACHE "$XDG_CACHE_HOME/npm"
set -gx NPM_CONFIG_TMP "$XDG_RUNTIME_DIR/npm"

# Python
set -gx PYENV_ROOT "$XDG_DATA_HOME/pyenv"
set -gx IPYTHONDIR "$XDG_CONFIG_HOME/jupyter"
set -gx JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME/jupyter"
set -gx PYTHON_CONFIG "$XDG_CONFIG_HOME/python"
set -gx MPLCONFIGDIR "$XDG_CONFIG_HOME/matplotlib"
set -gx PYLINTHOME "$XDG_CACHE_HOME/pylint"
set -gx PYTHONSTARTUP "$PYTHON_CONFIG/startup"
set -gx PYTHON_CFLAGS "-I"(xcrun --show-sdk-path)"/usr/include"
set -gx PYTHONBREAKPOINT "ipdb.set_trace"

# C++
set -gx VCPKG_ROOT (brew --prefix vcpkg)/libexec

# Aux
set -gx GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -gx TMUX_TMPDIR "$XDG_RUNTIME_DIR"
set -gx NVIM_LISTEN_ADDRESS "$XDG_RUNTIME_DIR/nvimsocket"
set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -gx XAUTHORITY "$XDG_RUNTIME_DIR/Xauthority"
set -gx TEXINPUTS ".:$XDG_DATA_HOME/texmf//:"

# User paths
set -g fish_user_paths \
	$HOME/.local/bin \
	$HOME/.local/share/bin \
	$PYENV_ROOT/bin \
	/usr/local/{bin,sbin} \
  /sbin \
  $HOME/.cargo/bin

# Aux
set -gx LESSHISTFILE -
set -gx __CF_USER_TEXT_ENCODING 0x(id -u):0x0:0x52

set -g grc_wrap_commands diff tail gcc g++ ifconfig make mount ping ps tail df
set -gx FZF_DEFAULT_COMMAND "rg --files --no-ignore --hidden --follow --glob '!.git/*'"
