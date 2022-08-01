case "$OSTYPE" in
linux-gnu)
    alias ls='ls --color=auto'
        
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    ;;
darwin*)
    alias ls="ls -h -G"
    ;;

esac

# some more ls aliases
alias ll='ls -alhF'
alias la='ls -Ah'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'#

alias pacman-autoremove='pacman -Qdtq | sudo pacman -Rs -'

function docker-tags {
  curl -s https://registry.hub.docker.com/v1/repositories/$1/tags | jq -r '.[].name'
}
