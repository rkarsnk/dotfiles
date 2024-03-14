#!/bin/bash

DOT_DIR="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"

GITHUB_URL="https://github.com/rkarsnk/dotfiles"
GITHUB_SSH="git@github.com:rkarsnk/dotfiles.git"

GITCONFIG_LOCAL="$HOME/.gitconfig.local"

LOGO="
_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
     | |      _    / __|_) |           
   _ | | ___ | |_ | |__ _| | ____  ___ 
  / || |/ _ \|  _)|  __) | |/ _  )/___)
 ( (_| | |_| | |__| |  | | ( (/ /|___ |
  \____|\___/ \___)_|  |_|_|\____|___/ 
_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
"

DIALOG="
author: @rkarsnk
repository: $GITHUB_URL

This script include:
(1) download dotfiles
(2) link dotfiles
"

what_is_os() {
  OS="unknown"
  if [ "$(uname)" = "Darwin" ]; then
    OS="macos"
  elif [ "$(uname)" = "Linux" ]; then
    . /etc/os-release
    if [ $ID = "debian" ]; then
      OS="debian"
    elif [ $ID = "arch" ];then
      OS="arch"
    fi
  fi
  echo $OS
}


dl_dotfiles() {
  if [ -d $DOT_DIR ]; then
    echo "$DOT_DIR is already exist."
  else
    echo "$DOT_DIR is not exist, clone now."
    if has "git"; then
      git clone --recursive $GITHUB_URL $DOT_DIR
    fi
  fi
}




OS=`what_is_os`

echo "$LOGO" "$DIALOG"
echo "OS is $OS."

# ~/.gitconfig.localが存在しない場合作成する．
if [ ! -f $GITCONFIG_LOCAL ]; then

  read -p "Enter git name: " GIT_NAME
  read -p "git email: " GIT_EMAIL 
  read -p "Repeat git email for validation: " GIT_EMAIL_CHECK

  # E-Mailアドレスに誤りがある場合は終了
  if [ $GIT_EMAIL != $GIT_EMAIL_CHECK ]; then
    echo "emailに誤りがあります．"
    exit 1
  else 
    while read line || [ -n "${line}" ]
    do
      echo $(eval echo "''${line}") >> $GITCONFIG_LOCAL
    done < gitconfig.local
  fi
fi

# .dotfilesを確認する．
dl_dotfiles

if [ $OS = "debian" ]; then
  . ./lib/debian_install_dotfiles.sh
elif [ $OS = "arch" ]; then
  . ./lib/arch_install_dotfiles.sh
elif [ $OS = "macos" ]; then
  . ./lib/macos_install_dotfiles.sh
fi

