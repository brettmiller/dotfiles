# brettmiller's dotfiles

## Install - setup a new computer

### Maunal process

- clone the repo
`git clone --bare https://github.com/brettmiller/dotfiles.git $HOME/.dotfiles`

- Set alias
`alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
and/or
`alias dtf='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
    (should also be added to .zshrc and/or .bashrc)

- Checkout the files to $HOME 
`dotfiles checkout`  

- If you have submodules
`dotfiles submodule update --init`

### Scripted process

`curl -L https://github.com/brettmiller/dotfiles/blob/main/.dotfiles/setup.sh | bash`

## Usage

Use the `dotfiles` or `dtf` alias in place of `git` to manage the repo

```dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Add .vimrc"
dotfiles add .zshrc
dotfiles commit -m "Add .zshrc"
dotfiles push
```

## New Repo Setup

- create a `.dotfiles` folder to track the files
`git init --bare $HOME/.dotfiles`

- create an alias called `dotfiles` that containes the git args so we don't have to keep typing it out
`alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`

- tell git to ignore untracked files so your entire `$HOME` doesn't show up as modified
`dotfiles config --local status.showUntrackedFiles no`

- add the alias to `.bashrc` or `.zshrc` so we can use it later
`echo "alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc`

- for zsh tab completion add this to .zshrc
```compdef _precommand dotfiles dtf```

### Resources

[smplman's dotfiles](https://raw.githubusercontent.com/smp4488/dotfiles/master/README.md)  
[How to manage your dotfiles with git](https://medium.com/@antelolive/how-to-manage-your-dotfiles-with-git-f7aeed8adf8b)  
[Ask HN: What do you use to manage dotfiles?](https://news.ycombinator.com/item?id=11070797)  
[The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles)
