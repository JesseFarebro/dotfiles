if status --is-interactive
  fish_vi_key_bindings

  # Bootstrap session
  if not functions -q fisher
      curl -sL https://git.io/fisher | source \
        and fisher update
  end

  # Source mamba if on macOS
  if type -q brew; and test -f (brew --prefix)/Caskroom/mambaforge/base/bin/conda
    eval (brew --prefix)/Caskroom/mambaforge/base/bin/conda "shell.fish" "hook" $argv | source
  end
end
