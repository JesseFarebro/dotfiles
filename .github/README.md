# dotfiles

<a href="#dotfiles">
  <img src="static/term.png" />
</a>

# Installation

```sh
git clone --bare https://github.com/jessefarebro/dotfiles $HOME/.dotfiles
alias dotfiles="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

dotfiles checkout
dotfiles config status.showUntrackedFiles no

. ~/.config/fish/config.fish
```

## MacOS Settings

```
# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 2

# Shorter delay until key repeat
defaults write NSGlobalDomain InitialKeyRepeat -int 15

```