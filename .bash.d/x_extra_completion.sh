# complete kubectl when called with the 'k' alias
complete -o default -F _k k 
complete -o default -F _k kg 

# Below was an attempt to get completion working with sub commands but it pulls completions for 'k' and not subs.
#complete -o default -F _k k $(awk '{FS="[ =]"} ; $2 ~ /^k/ {printf $2" "}' $HOME/.bash.d/gcp_aliases.bash)

