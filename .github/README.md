# dotfiles

alacritty + tmux + fish + neovim.

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

# Brew

Minimal list of brew dependencies for a new install.

<details>
  <summary>brew.txt</summary>

```
alacritty
bat
exa
fasd
fd
ffmpeg
fish
fzf
gpg2
git
grc
htop
imagemagick
latexit
mactex-no-gui
neovim
openconnect
openssh
prettyping
pyenv
ripgrep
safe-rm
skim
tldr
tmux
tree-sitter
wifi-password
```

</details>
