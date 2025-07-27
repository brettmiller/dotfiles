# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
#export HISTCONTROL=ignoredups
# ignores dups only if cmd above is the same (not in whole history file)
export HISTTIMEFORMAT="%F %T "
# Don't write to history if command is preceeded by a space
export HISTIGNORE="&:[ ]*:exit"
export HISTSIZE=500000
# allows all sessions history to be added (instead of last one to exit)
shopt -s histappend

# Write history on EXIT (write history if shell is killed by something other
# than 'exit/logout/^d, doesn't for SIGKILL)
trap "history -a" EXIT HUP INT QUIT ABRT ILL TERM

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Alias and function definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# user completions - source from brew first which will
# source $HOME/.bash_completion otherwise source it directly
if [ `uname -s` == "Darwin" ] && [ -f `brew --prefix`/etc/bash_completion ]; then
       . `brew --prefix`/etc/bash_completion
else
  if [ -f $HOME/.bash_completion ]; then
      . $HOME/.bash_completion
  fi
fi

# functions to list/change Java VMs. - moved to .bash.d as java_functions.sh
#source .java_functions_bashrc

# export DISPLAY for X11 forwarding works

if [ -z "$DISPLAY" ] ; then
    export DISPLAY=":0.0"
fi

# add list of servers from .ssh/known_hosts to tab completion list. useful for ssh hostname/ip completion.
if [[ -r ${HOME}/.ssh/known_hosts ]]; then
  complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh
fi

# Turn on biff mail notification
#biff y

# Allow 'write' messages
mesg y

# Disable the stty 'stop' control character (^S by default)
stty stop 'undef'

# User specific environment and startup programs

# Add /usr/local paths before defaults (needed for homebrew installed binaries to be found first)
# and put $HOME/bin before others to allow overriding both system and homebrew
PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$HOME/devel/adt-bundle-mac-x86_64/sdk/platform-tools:/opt/puppetlabs/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/code/github.com/vitalsource/vrse/bin:$PATH
ENV=$HOME/.bashrc

if [[ -x /usr/local/bin/vim ]]; then
  EDITOR="/usr/local/bin/vim"
else
  EDITOR="/usr/bin/vim"
fi

export PS1 ENV PATH EDITOR

# external bash included

[ -n "$USER_BASH_INCLUDES_DIR" ] || USER_BASH_INCLUDES_DIR=$HOME/.bash.d
readonly USER_BASH_INCLUDES_DIR

#  Induled/source all exteral files in $USER_BASH_INCLUDES_DIR (default is $HOME/.bash.d)
if [[ -d $USER_BASH_INCLUDES_DIR && -r $USER_BASH_INCLUDES_DIR && \
    -x $USER_BASH_INCLUDES_DIR ]]; then
    for i in $(LC_ALL=C command ls "$USER_BASH_INCLUDES_DIR" | grep -E -v ".*~|.*.bak|.*.swp|\#*\#|.*.dpkg*|.*.rpm*|Makefile.*|.*.off"); do
        i=$USER_BASH_INCLUDES_DIR/$i
        [[ -f $i && -r $i ]] && . "$i" #Uncomment for debugging -  && echo "included: $i"
    done
fi
unset i

complete -C /usr/local/bin/terraform terraform

# moved to .bash.d
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash


## SHOULD NO LONGER BE NEEDED - if `gcloud` exists and broken and python version is 3.9 and python3.8 is installed set CLOUDSDK_PYTHON version to 3.8
#if which gcloud ; then
#  if ! gcloud >/dev/null 2>&1 && python3 --version 2>/dev/null | grep -q 3.9; then
#    if /usr/local/opt/python@3.8/bin/python3.8 --version 2>/dev/null | grep -q 3.8; then
#      if [[ -z $CLOUDSDK_PYTHON ]]; then
#        export CLOUDSDK_PYTHON=/usr/local/opt/python@3.8/bin/python3.8
#      fi
#    else
#      echo 'WARNING: it appears `gcloud` is broken - try running `brew install python@3.8` and restarting your shell'
#    fi
#  fi
#fi
