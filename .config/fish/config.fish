fish_vi_key_bindings

set -gx EDITOR nvim
set -gx TERM alacritty
set -gx BROWSER open

# Bootstrap session
if not functions -q fisher
    curl -sL https://git.io/fisher | source; \
      and fisher install jorgebucaran/fisher
end

if status --is-login
  type -q pyenv; and pyenv init --path | source
end

if status --is-interactive
  type -q pyenv; and pyenv init - --no-rehash | source
end
