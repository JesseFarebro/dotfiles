fish_vi_key_bindings

set -gx EDITOR nvim
set -gx TERM alacritty

# Bootstrap session
if not functions -q fisher
    curl -sL https://git.io/fisher | source; \
      and fisher install jorgebucaran/fisher
end

set -g tide_print_newline_before_prompt true
set -g tide_prompt_char_icon "⟆ "
set -g tide_prompt_char_vi_insert_icon "⟆ "

# CTRL-c clears current line
bind -M insert \cC __fish_cancel_commandline

if status --is-interactive
    type -q pyenv; and pyenv init - | source
    type -q pyenv; and pyenv virtualenv-init - | source
    if not set -q TMUX; and type -q tmux
      exec tmux -2 new-session -A -s default
    end
end
