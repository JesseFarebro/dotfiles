fish_vi_key_bindings

set -gx EDITOR nvim
set -gx TERM alacritty

# Bootstrap session
if not functions -q fisher
    curl -sL https://git.io/fisher | source; \
      and fisher install jorgebucaran/fisher
end

if status --is-interactive
    type -q pyenv; and pyenv init - | source
    type -q pyenv; and pyenv virtualenv-init - | source
    starship init fish | source
    if not set -q TMUX; and type -q tmux
      exec tmux -2 new-session -A -s default
    end
end
