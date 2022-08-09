#!/usr/bin/env bash

# Must init micromamba before we clone override dotfiles.
# We'll take care of patching the script later
if command -v micromamba &> /dev/null
then
  micromamba shell init -p /opt/conda -s fish
  micromamba config set auto_activate_base true
fi

# Clone dotfiles
git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME reset --hard

# Re-add micromamba config with status is-interactive sheild
if command -v micromamba &> /dev/null
then
  tee -a $HOME/.config/fish/config.fish > /dev/null <<EOF
set -gx MAMBA_EXE "/bin/micromamba"
set -gx MAMBA_ROOT_PREFIX "/opt/conda"
status is-interactive && eval "/bin/micromamba" shell hook --shell fish --prefix "/opt/conda" | source
EOF
fi
