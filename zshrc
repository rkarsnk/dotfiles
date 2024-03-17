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

# WSL環境でWindowsのssh agentを利用する.
if [[ -v WSL_DISTRO_NAME ]] then
   if [[ -d "/opt/npiperelay/bin" ]] then
      export PATH=$PATH:/opt/npiperelay/bin
      export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
      ALREADY_RUNNING=$(ps -auxww | grep -q "[n]piperelay.exe -ei -s //./pipe/openssh-ssh-agent"; echo $?)
      if [[ $ALREADY_RUNNING != "0" ]] then
         if [[ -s $SSH_AUTH_SOCK ]] then
            rm $SSH_AUTH_SOCK
         fi
         NPIPERELAY="npiperelay.exe -ei -s //./pipe/openssh-ssh-agent"
         (setsid socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:$NPIPERELAY,nofork &) >/dev/null 2>&1
      fi
   fi
fi

if [[ -d "/opt/nvim-linux64/bin" ]] then
  export PATH=$PATH:/opt/nvim-linux64/bin
fi
bindkey -e
