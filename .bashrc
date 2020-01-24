# .bashrc

# Source global definitions
if [[ -f /etc/bashrc ]]; then
        . /etc/bashrc
fi

##### DEFAULTS #####

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

PROMPT_COLOR='35;1m'

export HISTCONTROL=ignoreboth
dpkg -l | grep "vim " | grep -q "ii "
if [[ $? -eq 0 ]] ; then
  export EDITOR="vim"
  export VISUAL="vim"
else
  echo "VIM is not installed"
  export EDITOR="vi"
  export VISUAL="vi"
fi
shopt -s histappend
shopt -s checkwinsize

# Make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Color prompt
force_color_prompt=yes

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# If this is an xterm set the title to user@host:dir
if [[ $(whoami) == "root" ]] ; then
        case "$TERM" in
                xterm*|rxvt*)
                        PS1='$([ $? -ne 0 ] && echo -e "\[\033[01;31m\]:[\[\e[0m\]" || echo -e "\[\033[01;32m\]:]\[\e[0m\]") ${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(parse_git_branch)\[\033[00m\] \$ '
                        ;;
                *)
                        PS1='$([ $? -ne 0 ] && echo -e "\[\033[01;31m\]:[\[\e[0m\]" || echo -e "\[\033[01;32m\]:]\[\e[0m\]") ${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(parse_git_branch)\[\033[00m\] \$ '
                        ;;
        esac
else
        case "$TERM" in
                xterm*|rxvt*)
                        PS1='$([ $? -ne 0 ] && echo -e "\[\033[01;31m\]:[\[\e[0m\]" || echo -e "\[\033[01;32m\]:]\[\e[0m\]") ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(parse_git_branch)\[\033[00m\] \$ '
                        ;;
                *)
                        PS1='$([ $? -ne 0 ] && echo -e "\[\033[01;31m\]:[\[\e[0m\]" || echo -e "\[\033[01;32m\]:]\[\e[0m\]") ${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(parse_git_branch)\[\033[00m\] \$ '
                        ;;
        esac
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


# source function and alias file
if [[ -f /home/$(whoami)/.functions_and_alias ]]; then
    . /home/$(whoami)/.functions_and_alias
fi
# source docker alias file
if [[ -f /home/$(whoami)/.docker_alias ]]; then
    . /home/$(whoami)/.docker_alias
fi

