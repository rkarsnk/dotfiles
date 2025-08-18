# ===============================================
# file: .zshrc
# 
#                              Written by rkarsnk
# ===============================================
DOTFILES=$HOME/.dotfiles
ZSH_DIR=$HOME/.zsh.d

# ~/.local/bin path
if [[ -d ~/.local/bin ]] then
    export PATH=$PATH:~/.local/bin
fi

# Cargo Env
if [[ -f $HOME/.cargo/env ]] then
    source "$HOME/.cargo/env"
fi


if [[ -d $ZSH_DIR ]] then
    . $ZSH_DIR/zsh_path
    . $ZSH_DIR/zsh_history
    . $ZSH_DIR/zsh_lscolors
    . $ZSH_DIR/zsh_prompt
    . $ZSH_DIR/zsh_aliases
    . $ZSH_DIR/zsh_completion
fi

bindkey -e
bindkey -r '^J' # Ctrl-j

# zcompile
if [[ ! -f ~/.zshrc.zwc ]] then
    zcompile ~/.zshrc
else
    if [[ ~/.zshrc -nt ~/.zshrc.zwc ]] then
       zcompile ~/.zshrc
    fi
fi
