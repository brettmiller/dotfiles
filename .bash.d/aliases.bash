# delcmd as written requires 'ignorespace' and doesn't show the removal in history
alias removelastcmd='history -d $((HISTCMD-2)) && history -d $((HISTCMD-1))'
alias rmlastcmd='history -d $((HISTCMD-2)) && history -d $((HISTCMD-1))'

alias get='git'
alias vim-install="rake -f ~/.vim/rakefile-vim-install"
alias mm='milkmaid'
alias hg='history | grep $*'
alias ll='ls -l'
alias pg='ps -ef | grep $*'
alias play='afplay'
alias strace='echo use dtruss \(dtrace script\)'
alias vi='vim'
alias tf='terraform'
alias fixvideo='sudo killall VDCAssistant'

# alias kubeenv/k8 functions to "better" names
alias k8no='nok8'
alias k8rm='rmk8'

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
	#alias ls='ls --color=auto'
	if $(ls --color >/dev/null 2>&1) ; then
		alias ls='ls --color'
	fi
	if [ `uname -s` == "Darwin" ] ; then
		alias ls='ls -G'
	fi
	#alias dir='ls -G --format=vertical'
	#alias vdir='ls -G --format=long'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# aliases
# Start python http server (optionally pass port to listen on, default is 8000)
alias webshare='python -m SimpleHTTPServer $1'
