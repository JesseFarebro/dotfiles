if status --is-interactive
    set -q fish_greeting; or set -g fish_greeting ""

    # Bootstrap fisher
    if not functions -q fisher
        curl -sL https://git.io/fisher | source; and fisher update
    end

    # Mamba
    if type -q micromamba; and set -q MAMBA_ROOT_PREFIX; and set -q MAMBA_EXE
        $MAMBA_EXE shell hook --shell fish --prefix $MAMBA_ROOT_PREFIX | source
    end

    # Direnv
    type -q direnv; and direnv hook fish | source

    # Zoxide
    type -q zoxide; and zoxide init fish | source
end
