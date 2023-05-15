#!/usr/bin/env bash
#
# Script to setup a new Mac
# TODO - add checks/options to make usable on linux
#
# download with `curl https://raw.githubusercontent.com/brettmiller/dotfiles/main/.dotfiles/new_computer_setup.sh -o new_computer_setup.sh`

# functions
install_prereq() {
  echo "Installing Xcode Command line tools"
  xcode-select --install
  echo "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)" ; hash -r
  echo "Installing Google Drive Desktop"
  brew install --cask google-drive
  echo -e "\n\nOpen and configure Google Drive Desktop.\nDirectories to sync:\n\n"
  echo '
    ${HOME}/scripts ${HOME}/scripts
    ${HOME}/scripts_saved ${HOME}/scripts_saved
    ${HOME}/Library/Application\ Support/Quicksilver
    ${HOME}/bin
    ${HOME}/Library/Services
    ${HOME}/Documents
    ?? ${HOME}/Notational_Data_work ${HOME}/notes ??

    '
  read -p "hit "Enter" to continue"
  echo -n "Test for/setup dotfiles repo: "
  install_dotfiles
}

install_dotfiles() {
  # test if dotfiles are already setup else setup
  if [[ -d ${HOME}/.dotfiles ]] && command -v dotfiles > /dev/null ; then
    echo "dotfiles repo already set"
  else
    echo "setting up dotfiles repo"
    curl -L https://github.com/brettmiller/dotfiles/raw/main/.dotfiles/setup.sh | zsh
  fi
}


main () {
  echo ""
  choice="z"
  while [ ! "$choice" == "y" -a ! "$choice" == "n" -a ! "$choice" == "i" ]; do
    read -p 'Homebrew, xcode cli tools, Google Drive Desktop, & dotfiles repo should be installed/setup before proceeding
  continue?

  y - yes (we good, already installed)
  n - no  (exit and install by hand)
  i - install brew, xcode cli, Google Drive Desktop, & dotfiles repo

  [y/n/i]?' choice
  done
  echo ""

  case $choice in
    n|N|no|No)
      exit 0
  ;;
    i|I|install)
     install_prereq "$@" ;;
  esac

  cd $HOME

  #if [[ -d ${HOME}/Dropbox ]]; then
  #  DROPBOXDIR="${HOME}/Dropbox"
  #else
  #  read -p "Enter full path to Dropbox directory" DROPBOXDIR
  #fi

  mkdir ${HOME}/tmp

  echo "Setting up some MacOS preferences"
  # set/change defaults and flags
  # Show Hidden files
  defaults write com.apple.finder AppleShowAllFiles -bool true
  # System Preferences > Dock > Magnification:
  defaults write com.apple.dock magnification -bool true
  # System Preferences > Dock > Size:
  defaults write com.apple.dock tilesize -int 21
  # System Preferences > Dock > Size (magnified):
  defaults write com.apple.dock largesize -int 65.125
  # System Preferences > Dock > Automatically hide and show the Dock:
  defaults write com.apple.dock autohide -bool false
  # System Preferences > Mission Controll > Automatically rearrange Spaces based on most recent use
  defaults write com.apple.dock mru-spaces -bool false
  # System Preferences > Mission Controll > Dashboard
  defaults write com.apple.dock dashboard-in-overlay -bool false
  # System Preferences > Desktop & Screensaver
  defaults -currentHost write com.apple.screensaver '{
      CleanExit = YES;
      PrefsVersion = 100;
      idleTime = 300;
      moduleDict =     {
          moduleName = "Computer Name";
          path = "/System/Library/Frameworks/ScreenSaver.framework/PlugIns/Computer Name.appex";
          type = 0;
      };
      showClock = 1;
  }'
  # System Preferences > Trackpad
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad '{
      Clicking = 1;
      DragLock = 0;
      Dragging = 0;
      TrackpadCornerSecondaryClick = 0;
      TrackpadFiveFingerPinchGesture = 2;
      TrackpadFourFingerHorizSwipeGesture = 2;
      TrackpadFourFingerPinchGesture = 2;
      TrackpadFourFingerVertSwipeGesture = 2;
      TrackpadHandResting = 1;
      TrackpadHorizScroll = 1;
      TrackpadMomentumScroll = 1;
      TrackpadPinch = 1;
      TrackpadRightClick = 1;
      TrackpadRotate = 1;
      TrackpadScroll = 1;
      TrackpadThreeFingerDrag = 0;
      TrackpadThreeFingerHorizSwipeGesture = 0;
      TrackpadThreeFingerTapGesture = 0;
      TrackpadThreeFingerVertSwipeGesture = 2;
      TrackpadTwoFingerDoubleTapGesture = 1;
      TrackpadTwoFingerFromRightEdgeSwipeGesture = 3;
      USBMouseStopsTrackpad = 0;
      UserPreferences = 1;
  }'
  # Unhide ~/Library
  chflags nohidden ~/Library/

  # Kill affected apps
  echo "Restarting Dock & Finder"
  for app in "Dock" "Finder"; do
    killall "${app}" > /dev/null 2>&1
  done

  ## Now syncs w/ Google Drive
  #echo "Removing Libary/Services to symlink"
  #sudo rmdir Library/Services

  ## Now using Google Drive Desktop for syncing outside of git dotfiles repo
  #echo 'Setting Dropbox symlinks'
  #ln -s ${DROPBOXDIR}/scripts ${HOME}/scripts
  #ln -s ${DROPBOXDIR}/scripts_saved ${HOME}/scripts_saved
  #ln -s ${DROPBOXDIR}/work_mac/home_dir/Libary/Application\ Support/Quicksilver ${HOME}/Library/Application\ Support/Quicksilver
  #ln -s ${DROPBOXDIR}/work_mac/home_dir/bin ${HOME}/bin
  #ln -s ${DROPBOXDIR}/Notational_Data_work ${HOME}/notes
  #ln -s ${DROPBOXDIR}/work_mac/home_dir/Libary/Services ${HOME}/Library/Services
  #ln -s ${DROPBOXDIR}/work_mac/home_dir/Brewfile ${HOME}/Brewfile
  #ln -s ${DROPBOXDIR}/work_mac/home_dir/.gitconfig ${HOME}/.gitconfig
  #ln -s ${DROPBOXDIR}/work_mac/home_dir/.vimrc ${HOME}/.vimrc
  #ln -s ${DROPBOXDIR}/work_mac/home_dir/.vim ${HOME}/.vim

  # needed configs(that aren't privacy concern) are in dotfiles repo
  #echo "Settina up ~/.config"
  #mkdir -p ${HOME}/.config
  #for dir in ${DROPBOXDIR}/work_mac/home_dir/.config/* ; do ln -s ${dir} ${HOME}/.config/$(basename ${dir}) ; done
  #echo "Setting up shell config"
  #for dir in ${DROPBOXDIR}/work_mac/shell/.* ; do ln -ihFs ${dir} ${HOME}/$(basename ${dir}) ; done

  echo "Setting permission to keep zsh from warning about insecure dirs"
  chmod 755 /usr/local/share/ /usr/local/share/zsh /usr/local/share/zsh/site-functions

  echo "Setting up ~/code base directories"
  mkdir -p ${HOME}/code/bitbucket.org/vstinf ${HOME}/code/github.com/{vitalsource,verba,GoogleCloudPlatform,brettmiller,other,icg}

  read -p 'To allow `brew` to install from the Apple App Store using `mas` sign in to the App Store then hit [Return]'

  echo "Installing software from Homebrew"
  brew bundle --file=${HOME}/Brewfile

  echo 'Add /usr/local/bin/zsh to /etc/shells (may ask for password to `sudo`)'
  echo '/usr/local/bin/zsh' >> /etc/shells || echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells

  echo "Making /usr/local/bin/zsh user's default shell"
  chsh -s /usr/local/bin/zsh

  # VS Code:
  # install VS Code sync extension !!disabled - config syncing is now built into VS code!!
  # /usr/local/bin/code --install-extension shan.code-settings-sync
  # enable key-repeating
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

  echo "Cloning 'kyrat'"
  cd ${HOME}/code/github.com/other
  git clone git@github.com:fsquillace/kyrat.git
  cd -
  echo ""

  echo "Remember - copy ssh keys (from 1password/lastpass/old computer) and/or setup 1Password ssh agent"
  echo "Remember - setup/clone VRSE"
  echo "Remember - copy shell history?"
  #echo "Remember - move ~/Documents/ from old computer (reconfigure syncing w/ Google Backup and Sync)"
  echo "Remember - configure VS Code syncing"
  echo "Remember - configure Jopin sync"
  echo -e "\n\n**Remember: Copy any 'private' shell rc directories**\n\n"
  #echo -e "\n\nSetup: \n Amphetamine \n Ethernet Status Lite \n Install: Outlook (https://portal.office.com/account) \n "
  echo -e "\n\nSetup: \n Amphetamine \n Install: Outlook (https://portal.office.com/account) \n "

  # gcloud get user credentials to use for ADC
  echo "gcloud auth adc"
  gcloud auth application-default login

  # set Chrome as default browser
  open -a "Google Chrome" --args --make-default-browser

}

main "$@"

