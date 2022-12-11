# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] &&
if [[ -f "/usr/local/opt/fzf/shell/completion.bash" ]]; then
  source "/usr/local/opt/fzf/shell/completion.bash" 2> /dev/null 
fi

# Key bindings
# ------------
if [[ -f "/usr/local/opt/fzf/shell/key-bindings.bash"  ]]; then 
  source "/usr/local/opt/fzf/shell/key-bindings.bash" 
fi
