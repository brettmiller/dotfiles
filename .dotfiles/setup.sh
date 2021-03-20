git clone --bare https://github.com/brettmiller/dotfiles.git $HOME/.dotfiles

alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

dotfiles checkout
dotfiles submodule update --init
