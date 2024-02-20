##############################
#
#  zsh config file: ~/.zshrc 
#
##############################
DOTFILES=$HOME/.dotfiles

if [[ -d $DOTFILES ]] then
    . $DOTFILES/zsh/zsh_path
    . $DOTFILES/zsh/zsh_history
    . $DOTFILES/zsh/zsh_lscolors
    . $DOTFILES/zsh/zsh_prompt
    . $DOTFILES/zsh/zsh_aliases
    . $DOTFILES/zsh/zsh_completion
fi


# Environment Module
if [[ -d /opt/envmodules/init ]] then
   . /opt/envmodules/init/zsh
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

if [[ -d ~/.config/anyenv ]] then
    eval "$(anyenv init -)"
fi

bindkey -e
