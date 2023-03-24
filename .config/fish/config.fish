if status --is-interactive
  fish_vi_key_bindings

  # Bootstrap session
  if not functions -q fisher
      curl -sL https://git.io/fisher | source \
        and fisher update
  end

  if type -q micromamba; and set -q MAMBA_ROOT_PREFIX; and set -q MAMBA_EXE
    $MAMBA_EXE shell hook --shell fish --prefix $MAMBA_ROOT_PREFIX | source
  end

  if type -q zoxide
    zoxide init fish | source
  end

  if type -q starship
    starship init fish | source
    enable_transience
  end
end
