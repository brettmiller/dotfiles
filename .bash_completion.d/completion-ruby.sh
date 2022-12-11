#!/bin/bash
#
# cloned from https://github.com/mernen/completion-ruby/
# 
if [[ -f ${HOME}/.bash_completion.d/completion-ruby/completion-ruby-all ]] && command -v ruby ; then
  source ${HOME}/.bash_completion.d/completion-ruby/completion-ruby-all
fi
