#!/usr/bin/env fish
# Install dotfiles
git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME reset --hard

# Configure fisher & tide
if not functions -q fisher
    curl -sL https://git.io/fisher | source \
      and fisher install jorgebucaran/fisher
end

fisher update
echo 3 1 1 1 1 1 2 2 2 4 2 1 y | tide configure >/dev/null

# Configure conda
if type -q conda
  conda init fish
end
