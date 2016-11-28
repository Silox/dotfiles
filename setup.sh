#!/usr/bin/env zsh

REPO=http://github.com/Silox/dotfiles
DEST="$HOME/.dotfiles"

if [[ -d $DEST ]];then
  cd $DEST && git pull origin master && cd -
else
  echo "cloning repo: $REPO into dir: $DEST"
  git clone $REPO $DEST
fi

function setup() {
    SRC="$1"
    DST="$2"
    echo "Installing $SRC..."

    mkdir -p $(dirname "$DST")
    ln -sfn "$DEST/$SRC" "$DST"
}

echo "Creating tmp dirs and symlinks in .vim"
mkdir -p $HOME/.config/nvim/tmp/{backup,swap}
ln -s $HOME/.dotfiles/vim/syntax $HOME/.config/nvim/syntax

setup init.vim "$HOME/.config/nvim/init.vim"
setup zshrc "$HOME/.zshrc"
setup tmux.conf "$HOME/.tmux.conf"
setup gitconfig "$HOME/.gitconfig"


echo "Cloning tmux-powerline into ~/.tmux"
pip install powerline-status

echo "updating Bundles"
vim +PlugInstall

reset
