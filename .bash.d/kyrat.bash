# If we have it use kyrat (SSH wrapper script that brings your dotfiles with you on Linux and OSX) for ssh

CLOUD_SDK_PATH="/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"

if [[ -z $SSH_CONNECTION ]] && command -v kyrat >/dev/null 2>&1; then

  alias ssh='kyrat'
  #alias ssh="${HOME}/repos/kyrat/bin/kyrat"

  # use sssh for standard ssh
  if [[ -x /usr/local/bin/ssh ]]; then
    alias sssh='/usr/local/bin/ssh'
  else
   alias sssh='/usr/bin/ssh'
  fi

  # make kyrat work with `gcloud compute ssh` if we aren't in an ssh session and have kyrat and gcloud
  if command -v gcloud >/dev/null 2>&1 && ! grep -q kyrat ${CLOUD_SDK_PATH}/lib/googlecloudsdk/command_lib/util/ssh/ssh.py; then
    cp -a ${CLOUD_SDK_PATH}/lib/googlecloudsdk/command_lib/util/ssh/ssh.py{,.orig}
    sed -i.orig -e "s/\('ssh.*'\): 'ssh'/\1: 'kyrat'/g" ${CLOUD_SDK_PATH}/lib/googlecloudsdk/command_lib/util/ssh/ssh.py
  fi
fi

# attempt to disable kyrat if we've got our dotiles from git
if ps aux | grep -q kyrat && [[ -n $SSH_CONNECTION ]] && [[ -d ${HOME}/.dotfiles ]]; then
  rm -rf $KYRAT_HOME
  echo "************RESTARTING SHELL*************"
  exec $SHELL -i
  alias base64=true
fi
