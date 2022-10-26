status --is-login || exit

# Fish
set -U fish_greeting

# Globals
set -Ux EDITOR nvim
set -Ux MANPAGER nvim +Man!
if type -q alacritty
  set -Ux TERM alacritty
end
if [ (uname) = "Darwin" ]
  set -Ux BROWSER open
end

# XDG
set -Ux XDG_DATA_HOME "$HOME/.local/share"
set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux XDG_CACHE_HOME "$HOME/.cache"
switch (uname)
  case Linux
    if test -d /run/user/(id -u)
      set -Ux XDG_RUNTIME_DIR /run/user/(id -u)
    else
      set -Ux XDG_RUNTIME_DIR $TMPDIR"runtime-$USER"
    end
  case Darwin
    set -Ux XDG_RUNTIME_DIR $TMPDIR"runtime-$USER"
end
if not test -d $XDG_RUNTIME_DIR
  # create XDG_RUNTIME_DIR on login if not exist
  mkdir -p $XDG_RUNTIME_DIR
end

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
set -Ux IPYTHONDIR "$XDG_CONFIG_HOME/jupyter"
set -Ux JUPYTER_CONFIG_DIR "$XDG_CONFIG_HOME/jupyter"
set -Ux PYTHON_CONFIG "$XDG_CONFIG_HOME/python"
set -Ux MPLCONFIGDIR "$XDG_CONFIG_HOME/matplotlib"
set -Ux PYLINTHOME "$XDG_CACHE_HOME/pylint"
set -Ux PYTHONSTARTUP "$PYTHON_CONFIG/startup"
if [ (uname) = "Darwin" ]
  set -Ux PYTHON_CFLAGS "-I"(xcrun --show-sdk-path)"/usr/include"
end

# Rust
set -Ux CARGO_HOME "$XDG_DATA_HOME/cargo"
set -Ux RUSTUP_HOME "$XDG_DATA_HOME/rustup"
fish_add_path $CARGO_HOME/bin

# C++
if type -q brew
  set -Ux VCPKG_ROOT "$XDG_DATA_HOME/vcpkg"
end

# Aux
set -Ux GNUPGHOME "$XDG_DATA_HOME/gnupg"
set -Ux TMUX_TMPDIR "$XDG_RUNTIME_DIR"
set -Ux NVIM_LISTEN_ADDRESS "$XDG_RUNTIME_DIR/nvimsocket"
set -Ux DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set -Ux XAUTHORITY "$XDG_RUNTIME_DIR/Xauthority"
set -Ux TEXINPUTS ".:$XDG_DATA_HOME/texmf//:"

# Aux
set -Ux LESSHISTFILE -
set -Ux __CF_USER_TEXT_ENCODING 0x(id -u):0x0:0x52
set -Ux FZF_DEFAULT_COMMAND "rg --files --no-ignore --hidden --follow --glob '!.git/*'"
