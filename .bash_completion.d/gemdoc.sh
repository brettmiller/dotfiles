#!/bin/sh
#
# yanked from rick bradley - https://github.com/rick/dotfiles/blob/master/.bash.d/030-gemdoc.sh
# modded to check from `gem` before running

if command -v gem ;then
  # gem documentation via gemdoc (with tab completion)
  export GEMDIR=`gem env gemdir`
  
  gemdoc() {
    open $GEMDIR/doc/`$(which ls) $GEMDIR/doc | grep $1 | sort | tail -1`/rdoc/index.html
  }
  
  _gemdocomplete() {
    COMPREPLY=($(compgen -W '$(`which ls` $GEMDIR/doc)' -- ${COMP_WORDS[COMP_CWORD]}))
    return 0
  }
  
  complete -o default -o nospace -F _gemdocomplete gemdoc
fi
