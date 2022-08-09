#!/usr/bin/env fish

# Must init micromamba before we clone override dotfiles.
# We'll take care of patching the script later
if type -q "micromamba"
  micromamba shell init -p /opt/conda -s fish
  micromamba config set auto_activate_base true
end

# Clone dotfiles
git --git-dir=$HOME/.dotfiles/.git --work-tree=$HOME reset --hard

# Execute in fish login shell
exec fish -l

# Write micromamba init
if type -q "micromamba"
  tee -a ~/.config/fish/config.fish << EOF
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
set -gx MAMBA_EXE "/bin/micromamba"
set -gx MAMBA_ROOT_PREFIX "/opt/conda"
status is-interactive && eval "/bin/micromamba" shell hook --shell fish --prefix "/opt/conda" | source
# <<< mamba initialize <<<
  EOF
end
