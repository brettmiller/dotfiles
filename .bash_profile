#!/bin/sh
# .bash_profile
#
# All bash configuration should be put in .bashrc unless you only want it 
# run on 

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

if [[ -f "/Users/bmille2/code/github.com/vitalsource/vrse/SOURCEME" ]]; then
  source "/Users/bmille2/code/github.com/vitalsource/vrse/SOURCEME" # Added by VRSE
fi
