if status --is-interactive
    fish_vi_key_bindings

    # Bootstrap fisher
    if not functions -q fisher
        curl -sL https://git.io/fisher | source; and fisher update
    end

    type -q direnv; and direnv hook fish | source

    # Mamba
    if type -q micromamba; and set -q MAMBA_ROOT_PREFIX; and set -q MAMBA_EXE
        $MAMBA_EXE shell hook --shell fish --prefix $MAMBA_ROOT_PREFIX | source
    end

    # Zoxide
    type -q zoxide; and zoxide init fish | source
end
