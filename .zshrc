# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' insert-unambiguous true
#zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-colors true
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=long
#zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/Users/bmille2/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install

# history settings move to end of rc loading in ~/.zsh.d/90_history
#HISTFILE=~/.zsh_history
#HISTSIZE=250000
#SAVEHIST=500000
#setopt appendhistory
#setopt histignorespace
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install

# Disable the stty 'stop' control character (^S by default)
stty stop 'undef'

# allow comments '#' in interactive shells
set -k

# external included
[ -n "$USER_ZSH_INCLUDES_DIR" ] || USER_ZSH_INCLUDES_DIR=$HOME/.zsh.d
readonly USER_ZSH_INCLUDES_DIR

#  Inclued/source all exteral files in $USER_ZSH_INCLUDES_DIR (default is $HOME/.zsh.d)
if [[ -d $USER_ZSH_INCLUDES_DIR && -r $USER_ZSH_INCLUDES_DIR && \
    -x $USER_ZSH_INCLUDES_DIR ]]; then
    for i in $(LC_ALL=C command ls "$USER_ZSH_INCLUDES_DIR" | grep -E -v ".*~|.*.bak|.*.swp|\#*\#|.*.dpkg*|.*.rpm*|Makefile.*|.*.off|.*-off"); do
        i=$USER_ZSH_INCLUDES_DIR/$i
        [[ -f $i && -r $i ]] && . "$i" #&& echo "included: $i" # <<-- Uncomment for debugging
    done
fi
unset i

autoload -U +X bashcompinit && bashcompinit

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

#PATH=${HOME}/bin:${PATH}

# enabling VRSE moved to ~/.zsh.d/10_vrse - leaving the below line but commented to apease VRSE and not be questioned again
#source "/Users/bmille2/code/github.com/vitalsource/vrse/SOURCEME.zsh" # Added by VRSE


#### as of 2022-03-25 gcloud w/ python 3.9 isn't broken
# 20201029 - BREAKING CHANGES                                                                                       # ${vrse_watermark}
# if `gcloud` is broken and python version is 3.9 and python3.8 is installed set CLOUDSDK_PYTHON version to 3.8     # ${vrse_watermark}
#if ! gcloud >/dev/null 2>&1 && python3 --version 2>/dev/null | grep -q 3.9; then                                                # ${vrse_watermark}
#  if $(brew --prefix)/opt/python@3.8/bin/python3.8 --version 2>/dev/null | grep -q 3.8; then                        # ${vrse_watermark}
#    if [[ -z $CLOUDSDK_PYTHON ]]; then                                                                              # ${vrse_watermark}
#      export CLOUDSDK_PYTHON="$(brew --prefix)/opt/python@3.8/bin/python3.8"                                        # ${vrse_watermark}
#    fi                                                                                                              # ${vrse_watermark}
#  else                                                                                                              # ${vrse_watermark}
#    echo 'WARNING: it appears `gcloud` is broken - try running `brew install python@3.8` and restarting your shell' # ${vrse_watermark}
#  fi                                                                                                                # ${vrse_watermark}
#fi                                                                                                                  # ${vrse_watermark}


# added by Snowflake SnowSQL installer v1.2
#export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH
