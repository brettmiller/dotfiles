git clone --bare https://github.com/brettmiller/dotfiles.git $HOME/.dotfiles

alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

dotfiles checkout
dotfiles submodule update --init
# after --init submodules will be detatched from HEAD, checkout default branch and pull
dotfiles submodule foreach 'default_branch="$(git symbolic-ref refs/remotes/origin/HEAD)"; git checkout ${default_branch##*/} && git pull'
