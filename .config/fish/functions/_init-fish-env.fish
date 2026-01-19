function _init-fish-env --description "Bootstrap Universal environment variables and XDG paths"
    set -Ux XDG_DATA_HOME "$HOME/.local/share"
    set -Ux XDG_CONFIG_HOME "$HOME/.config"
    set -Ux XDG_CACHE_HOME "$HOME/.cache"
    set -Ux XDG_STATE_HOME "$HOME/.local/state"

    # Globals
    set -Ux EDITOR nvim
    set -Ux MANPAGER nvim +ZenMode +Man!

    fish_add_path -U $HOME/.local/share/bin $HOME/.local/bin /usr/local/bin /usr/local/sbin /usr/bin /bin /usr/sbin /sbin

    if test (uname) = Darwin
        set -Ux BROWSER open
    end

    # Tool-Specific Exports

    # Homebrew
    set -Ux HOMEBREW_NO_ANALYTICS 1
    if test (uname) = Darwin
        set -Ux HOMEBREW_PREFIX /opt/homebrew
        set -Ux HOMEBREW_CELLAR /opt/homebrew/Cellar

        set -Ux HOMEBREW_REPOSITORY /opt/homebrew

        fish_add_path -U -m /opt/homebrew/bin /opt/homebrew/sbin
    end

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
    if test (uname) = Darwin
        set -Ux PYTHON_CFLAGS "-I"(xcrun --show-sdk-path)"/usr/include"
    end

    # Rust
    set -Ux CARGO_HOME "$XDG_DATA_HOME/cargo"
    set -Ux RUSTUP_HOME "$XDG_DATA_HOME/rustup"

    # Julia
    set -Ux JULIA_DEPOT_PATH "$XDG_DATA_HOME/julia"
    set -Ux JULIAUP_DEPOT_PATH "$XDG_DATA_HOME/julia"

    # C++
    set -Ux VCPKG_ROOT "$XDG_DATA_HOME/vcpkg"

    # Aux
    set -Ux GNUPGHOME "$XDG_DATA_HOME/gnupg"
    set -Ux DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
    set -Ux TEXINPUTS ".:$XDG_DATA_HOME/texmf//:"

    # Aux
    set -Ux LESSHISTFILE -
    set -Ux __CF_USER_TEXT_ENCODING 0x(id -u):0x0:0x52
    set -Ux FZF_DEFAULT_COMMAND "rg --files --no-ignore --hidden --follow --glob '!.git/*'"

    # Create useful directories
    test -d $XDG_CACHE_HOME/ssh/sockets || mkdir -p -m 700 $XDG_CACHE_HOME/ssh/sockets

    if type -q tide
        tide configure --auto --style=Lean --prompt_colors='True color' --show_time='12-hour format' --lean_prompt_height='Two lines' --prompt_connection=Dotted --prompt_connection_andor_frame_color=Darkest --prompt_spacing=Sparse --icons='Few icons' --transient=Yes

        set -U tide_left_prompt_items pwd git newline character
        set -U tide_right_prompt_items status cmd_duration context jobs time
    end
end
