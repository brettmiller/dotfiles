# brettmiller's dotfiles

## Install - setup a new computer

### Scripted process
curl can be piped to `zsh` or `bash`

`curl -L https://github.com/brettmiller/dotfiles/raw/main/.dotfiles/setup.sh | zsh`

### Maunal process

- clone the repo  
`git clone --bare https://github.com/brettmiller/dotfiles.git $HOME/.dotfiles`
or  
`git clone --bare git@github.com:brettmiller/dotfiles.git $HOME/.dotfiles`

- Set alias  
`alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
and/or  
`alias dtf='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
    (should also be added to .zshrc and/or .bashrc)
- Reset HEAD --hard to keep from getting errors about existing files  
`dotfiles reset HEAD --hard`
- Checkout the files to $HOME  
`dotfiles checkout`  
- If you have submodules  
`dotfiles submodule update --init`

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
`alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`

- tell git to ignore untracked files so your entire `$HOME` doesn't show up as modified  
`dotfiles config --local status.showUntrackedFiles no`

- add the alias to `.bashrc` or `.zshrc` so we can use it later  
`echo "alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.bashrc`

- for zsh tab completion add this to .zshrc  
```compdef _precommand dotfiles dtf```

### Requirements
- [Oh-My-Zsh](https://ohmyz.sh/) - just the repo cloned to ${HOME}/.oh-my-zsh (don't use their installer)  
`git clone https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh` (scripted install process handles this)

### Useful but not required
- [fzf](https://github.com/junegunn/fzf)

### Resources

[smplman's dotfiles](https://github.com/smp4488/dotfiles)  
[How to manage your dotfiles with git](https://medium.com/@antelolive/how-to-manage-your-dotfiles-with-git-f7aeed8adf8b)  
[Ask HN: What do you use to manage dotfiles?](https://news.ycombinator.com/item?id=11070797)  
[The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles)
