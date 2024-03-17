#!/bin/bash

echo "#### Install dotfiles for Debian/GNU Linux ####"

echo "---- Begin installation: git config dir ----"
[ -d "~/.config/git" ] && mv $CONFIG_DIR/git $CONFIG_DIR/git.bak
ln -sf $DOT_DIR/config/git $CONFIG_DIR/git
echo "---- End ----"

echo "---- Begin installation: zsh config dir ----"
[ -d "$CONFIG_DIR/zsh" ] && mv $CONFIG_DIR/zsh $CONFIG_DIR/zsh.bak
ln -sf $DOT_DIR/config/zsh $CONFIG_DIR/zsh
echo "---- End ----"

echo "---- Begin Installation: neovim config dir ----"
[ -d "$CONFIG_DIR/nvim" ] && mv $CONFIG_DIR/nvim $CONFIG_DIR/nvim.bak
ln -sf $DOT_DIR/config/nvim $CONFIG_DIR/nvim
echo "---- End ----"

echo "---- Begin Installation: tmux config dir ----"
[ -d "$CONFIG_DIR/tmux" ] && mv $CONFIG_DIR/tmux $CONFIG_DIR/tmux.bak
ln -sf $DOT_DIR/config/tmux $CONFIG_DIR/tmux
echo "---- End ----"
