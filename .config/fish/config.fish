if status --is-interactive

    fish_vi_key_bindings

    # Mamba
    if type -q micromamba; and set -q MAMBA_ROOT_PREFIX; and set -q MAMBA_EXE
        $MAMBA_EXE shell hook --shell fish --prefix $MAMBA_ROOT_PREFIX | source
    end

    # pyenv
    type -q pyenv; and pyenv init - | source

    # Zoxide
    type -q zoxide; and zoxide init fish | source

    # 1Password completions
    type -q op; and op completion fish | source

    # direnv
    type -q direnv; and direnv hook fish | source

    # devbox
    type -q devbox; and devbox global shellenv --init-hook | source
end
