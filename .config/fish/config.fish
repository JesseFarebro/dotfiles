if status --is-interactive
  fish_vi_key_bindings

  # Bootstrap session
  if not functions -q fisher
      curl -sL https://git.io/fisher | source \
        and fisher install jorgebucaran/fisher
  end

  type -q pyenv; and pyenv init - --no-rehash | source
end
