##############################
#
#  zsh config file: ~/.zshrc 
#
##############################
DOTFILES=$HOME/.dotfiles
CONF_DIR=$HOME/.config

if [[ -d $CONF_DIR ]] then
    . $CONF_DIR/zsh/zsh_path
    . $CONF_DIR/zsh/zsh_history
    . $CONF_DIR/zsh/zsh_lscolors
    . $CONF_DIR/zsh/zsh_prompt
    . $CONF_DIR/zsh/zsh_aliases
    . $CONF_DIR/zsh/zsh_completion
fi

# local-bin path
if [[ -d ~/.local/bin ]] then
    export PATH=$PATH:~/.local/bin
fi


# Cargo Env
if [[ -f $HOME/.cargo/env ]] then
    source "$HOME/.cargo/env"
fi


# zcompile
if [[ ! -f ~/.zshrc.zwc ]] then
    zcompile ~/.zshrc
else
    if [[ ~/.zshrc -nt ~/.zshrc.zwc ]] then
       zcompile ~/.zshrc
    fi
fi

bindkey -e
bindkey -r '^J' # Ctrl-j
