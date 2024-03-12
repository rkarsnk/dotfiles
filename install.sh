#!/bin/bash

DOT_DIR="$HOME/.dotfiles"
GITHUB_URL="https://github.com/rkarsnk/dotfiles"
GITHUB_SSH="git@github.com:rkarsnk/dotfiles.git"

LOGO="
  _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
       _             ___ _ _            
      | |      _    / __|_) |           
    _ | | ___ | |_ | |__ _| | ____  ___ 
   / || |/ _ \|  _)|  __) | |/ _  )/___)
  ( (_| | |_| | |__| |  | | ( (/ /|___ |
   \____|\___/ \___)_|  |_|_|\____|___/ 

  _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
"

DIALOG="
  author: @rkarsnk
  repository: $GITHUB_URL

  This script include:
  (1) download dotfiles
  (2) link dotfiles
"

OS="unknown"
if [ "$(uname)" = "Darwin" ]; then
  OS="macos"
elif [ "$(uname)" = "Linux" ]; then
  OS="linux"
fi

dl_dotfiles() {
  if [ -d $DOT_DIR ]; then
    echo "$DOT_DIR is already exist."
  else
    if has "git"; then
      git clone --recursive $GITHUB_SSH $DOT_DIR
    fi
  fi
}

echo "$LOGO" "$DIALOG"
echo "OS is $OS."

read -p "enter git name: " GIT_NAME
read -p "your git email: " GIT_EMAIL 
read -p "re-type your git email: " GIT_EMAIL_CHECK
if [ $GIT_EMAIL = $GIT_EMAIL_CHECK ]; then
  echo "Mail OK."
else
  echo "Mail NG."
fi

