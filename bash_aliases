case "$OSTYPE" in
linux-gnu)
    alias ls="ls -h --color=auto"
    ;;
darwin*)
    alias ls="ls -h -G"
    ;;

esac
