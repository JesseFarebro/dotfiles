status --is-login || exit

# Fish
set -U fish_greeting
# Cursors
set -U fish_cursor_insert line
set -U fish_cursor_replace_one underscore
set -U fish_cursor_visual block

# Globals
set -Ux EDITOR nvim
set -Ux MANPAGER nvim +ZenMode +Man!
if type -q ghostty
    set -Ux TERM ghostty
end
if [ (uname) = Darwin ]
    set -Ux BROWSER open
end

# XDG
set -Ux XDG_DATA_HOME "$HOME/.local/share"
set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux XDG_CACHE_HOME "$HOME/.cache"
set -Ux XDG_STATE_HOME "$HOME/.local/state"

# User paths
set -Ux fish_user_paths \
    $HOME/.local/{share/bin,bin} \
    /usr/local/{bin,sbin} \
    /{bin,sbin}

# ncurses
set -Ux TERMINFO "$XDG_DATA_HOME/terminfo"
set -Ux TERMINFO_DIRS "$XDG_DATA_HOME/terminfo:/usr/share/terminfo"

# Node
set -Ux NODE_REPL_HISTORY "$XDG_DATA_HOME/node_repl_history"
set -Ux NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/config"
set -Ux NPM_CONFIG_CACHE "$XDG_CACHE_HOME/npm"

# Python
set -Ux MAMBA_ROOT_PREFIX "$XDG_DATA_HOME/micromamba"
set -Ux MAMBARC "$XDG_CONFIG_HOME/mamba/mambarc"
set -Ux IPYTHONDIR "$XDG_CONFIG_HOME/jupyter"
set -Ux JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME/jupyter"
set -Ux PYTHON_CONFIG "$XDG_CONFIG_HOME/python"
set -Ux PYTHON_HISTORY "$XDG_STATE_HOME/python/history"
set -Ux MPLCONFIGDIR "$XDG_CONFIG_HOME/matplotlib"
set -Ux PYLINTHOME "$XDG_CACHE_HOME/pylint"
set -Ux PIPX_HOME "$XDG_DATA_HOME/pipx"
set -Ux TFDS_DATA_DIR "$XDG_CACHE_HOME/tfds"
if type -q brew
    set -Ux MAMBA_EXE (brew --prefix micromamba)/bin/micromamba
end
if [ (uname) = Darwin ]
    set -Ux PYTHON_CFLAGS "-I"(xcrun --show-sdk-path)"/usr/include"
end

# Rust
set -Ux CARGO_HOME "$XDG_DATA_HOME/cargo"
set -Ux RUSTUP_HOME "$XDG_DATA_HOME/rustup"
fish_add_path $CARGO_HOME/bin

# Julia
set -Ux JULIA_DEPOT_PATH "$XDG_DATA_HOME/julia"
set -Ux JULIAUP_DEPOT_PATH "$XDG_DATA_HOME/julia"

# C++
set -Ux VCPKG_ROOT "$XDG_DATA_HOME/vcpkg"

# Aux
set -Ux GNUPGHOME "$XDG_DATA_HOME/gnupg"
# set -Ux DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -Ux TEXINPUTS ".:$XDG_DATA_HOME/texmf//:"

# Aux
set -Ux LESSHISTFILE -
set -Ux __CF_USER_TEXT_ENCODING 0x(id -u):0x0:0x52
set -Ux FZF_DEFAULT_COMMAND "rg --files --no-ignore --hidden --follow --glob '!.git/*'"
