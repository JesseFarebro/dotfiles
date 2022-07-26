#!/usr/bin/env fish
# Install dotfiles
git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME reset --hard

# Configure conda
if type -q conda
  conda init fish
end
