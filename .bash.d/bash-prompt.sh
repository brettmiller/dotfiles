# Prompt Colors

TEXT_BLACK='\[\e[0;30m\]'  # Black - Regular
TEXT_RED='\[\e[0;31m\]'    # Red
TEXT_GREEN='\[\e[0;32m\]'  # Green
TEXT_YELLOW='\[\e[0;33m\]' # Yellow
TEXT_BLUE='\[\e[0;34m\]'   # Blue
TEXT_PURPLE='\[\e[0;35m\]' # Purple
TEXT_CYAN='\[\e[0;36m\]'   # Cyan
TEXT_WHITE='\[\e[0;37m\]'  # White
# BLDBLK='\[\e[1;30m\]' # Black - Bold
# BLDRED='\[\e[1;31m\]' # Red
# BLDGRN='\[\e[1;32m\]' # Green
# BLDYLW='\[\e[1;33m\]' # Yellow
# BLDBLU='\[\e[1;34m\]' # Blue
# BLDPUR='\[\e[1;35m\]' # Purple
# BLDCYN='\[\e[1;36m\]' # Cyan
# BLDWHT='\[\e[1;37m\]' # White
# UNDBLK='\[\e[4;30m\]' # Black - Underline
# UNDRED='\[\e[4;31m\]' # Red
# UNDGRN='\[\e[4;32m\]' # Green
# UNDYLW='\[\e[4;33m\]' # Yellow
# UNDBLU='\[\e[4;34m\]' # Blue
# UNDPUR='\[\e[4;35m\]' # Purple
# UNDCYN='\[\e[4;36m\]' # Cyan
# UNDWHT='\[\e[4;37m\]' # White
# BAKBLK='\[\e[40m\]'   # Black - Background
# BAKRED='\[\e[41m\]'   # Red
# BAKGRN='\[\e[42m\]'   # Green
# BAKYLW='\[\e[43m\]'   # Yellow
# BAKBLU='\[\e[44m\]'   # Blue
# BAKPUR='\[\e[45m\]'   # Purple
# BAKCYN='\[\e[46m\]'   # Cyan
# BAKWHT='\[\e[47m\]'   # White
TEXT_RESET='\[\e[0m\]'    # Text Reset

# Check for SSH and GCP
if [[ -n $SSH_CONNECTION ]]; then
	GCP_PROJECT=$(gcloud info --format="value(config.project)" 2>/dev/null)
	if [[ -n $GCP_PROJECT ]]; then
    REMOTE="[${TEXT_RED}GCP: ${GCP_PROJECT}${TEXT_RESET}]"
  else
    REMOTE="[${TEXT_RED}REMOTE${TEXT_RESET}]"
  fi
else
  REMOTE=''
fi

# 2 line prompt w/ user@hostname, day, date, and time on 1st line and $PWD (and cursor) on 2nd. 
PS1="[${TEXT_GREEN}\u${TEXT_RESET}@${TEXT_GREEN}\h${TEXT_RESET}] [${TEXT_YELLOW}\d \t${TEXT_RESET}]\n\w\$ "
# Same as above with Git status at end of the first line
#PS1="[${TEXT_GREEN}\u${TEXT_RESET}@${TEXT_GREEN}\h${TEXT_RESET}] [${TEXT_YELLOW}\d \t${TEXT_RESET}] $(__git_ps1 " (%s)") \n\w\$ "

# **OFF**  use different colors and set "[REMOTE]" in prompt if UID is common UID on remote systems
# MY_UID="###"
#if [[ $(id -u) -eq "${MY_UID}" ]] || [[ -n $SSH_CONNECTION ]] ; then

# Use different colors and set "[REMOTE]" in prompt if connected via ssh ($SSH_CONNECTION is set )
if [[ -n $SSH_CONNECTION ]] ; then
  PS1="[${TEXT_BLUE}\u${TEXT_RESET}@${TEXT_BLUE}\h${TEXT_RESET}] [${TEXT_CYAN}\d \t${TEXT_RESET}]${REMOTE}\n\w\$ "
fi


