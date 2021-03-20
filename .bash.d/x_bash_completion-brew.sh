#!/bin/bash
#
# Need to run after the alias_completion function (in x_alias_completion.sh) otherwise it
# can screw up directory and file name completion when they have spaces in the name.

if [[ $(uname -s) == 'Darwin'  ]] ; then
  if [ -f `brew --prefix`/etc/bash_completion  ]; then
    source $(brew --prefix)/etc/bash_completion
  fi
fi
