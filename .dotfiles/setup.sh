echo "Cloning Oh-My-Zsh"
git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh

echo "Cloning dotfiles repo, trying with ssh and will fall back to https"
git clone --bare git@github.com:brettmiller/dotfiles.git $HOME/.dotfiles || \
git clone --bare https://github.com/brettmiller/dotfiles.git $HOME/.dotfiles

#alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
function dotfiles {
  git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

# reset HEAD --hard so we don't get errors about existing files
dotfiles reset HEAD --hard
dotfiles fetch --set-upstream origin main
dotfiles checkout
dotfiles submodule update --init
# after --init submodules will be detatched from HEAD, checkout default branch and pull
dotfiles submodule foreach 'default_branch="$(git symbolic-ref refs/remotes/origin/HEAD)"; git checkout ${default_branch##*/} && git pull'
