if status --is-interactive
  fish_vi_key_bindings

  # Bootstrap fisher
  if not functions -q fisher
      curl -sL https://git.io/fisher | source \
        and fisher update
  end

  # Mamba
  if type -q micromamba; and set -q MAMBA_ROOT_PREFIX; and set -q MAMBA_EXE
    $MAMBA_EXE shell hook --shell fish --prefix $MAMBA_ROOT_PREFIX | source
  end

  # Zoxide
  type -q zoxide; and zoxide init fish | source

  # 1Password completions
  type -q op; and op completion fish | source

  # Starship
  if type -q starship
    starship init fish | source
    enable_transience
  end
end
