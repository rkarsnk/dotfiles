DOTFILES=$HOME/.dotfiles

typeset -U path PATH
path=(
  /opt/local/bin(N-/)
  /opt/local/sbin(N-/)
  /usr/bin
  /usr/sbin
  /bin
  /sbin
  /usr/local/bin(N-/)
  /usr/local/sbin(N-/)
  /Library/Apple/usr/bin
)

if [[ -d $DOTFILES ]] then
    . $DOTFILES/zsh/zsh_history
    . $DOTFILES/zsh/zsh_lscolors
    . $DOTFILES/zsh/zsh_prompt
    . $DOTFILES/zsh/zsh_aliases
    . $DOTFILES/zsh/zsh_completion
fi


if [[ ! -f ~/.zshrc.zwc ]] then
    zcompile ~/.zshrc
else
    if [[ ~/.zshrc -nt ~/.zshrc.zwc ]] then
       zcompile ~/.zshrc
    fi
fi

