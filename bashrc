# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
COLUMNS=150
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
#if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#    debian_chroot=$(cat /etc/debian_chroot)
#fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    sharp=`echo -e "\uE0B0"`
    # foreground color
    FG_BLACK="\[$(tput setaf 0)\]"
    FG_RED="\[$(tput setaf 1)\]"
    FG_GREEN="\[$(tput setaf 2)\]"
    FG_YELLOW="\[$(tput setaf 3)\]"
    FG_BLUE="\[$(tput setaf 4)\]"
    FG_PURPLE="\[$(tput setaf 5)\]"
    FG_SKY="\[$(tput setaf 6)\]"
    FG_WHITE="\[$(tput setaf 7)\]"
    # background color
    BG_BLACK="\[$(tput setab 0)\]"
    BG_RED="$\[(tput setab 1)\]"
    BG_GREEN="\[$(tput setab 2)\]"
    BG_YELLOW="\[$(tput setab 3)\]"
    BG_BLUE="\[$(tput setab 4)\]"
    BG_PURPLE="\[$(tput setab 5)\]"
    BG_SKY="\[$(tput setab 6)\]"
    BG_WHITE="\[$(tput setab 7)\]"
    # color reset
    RESET="\[$(tput sgr0)\]"
    # shell prompt
    PS1="${BG_WHITE}${FG_RED}\u@\h${RESET}${BG_BLUE}${FG_WHITE}${sharp} \w \$${FG_BLUE}${RESET}${FG_BLUE}${sharp}${RESET} "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt


# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
if [ -f ~/.dotfiles/bash_aliases ]; then
    . ~/.dotfiles/bash_aliases
fi

# LS_COLORS
if [ -x /usr/bin/dircolors ]; then
    if [ -f ~/.colorrc ]; then
        eval `dircolors ~/.colorrc`
    fi
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# make homebrew's completions available in bash
if type brew &>/dev/null
then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi

