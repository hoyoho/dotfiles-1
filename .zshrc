#!/bin/zsh

# Aliases
alias python='python2'
alias ls='ls -G -h' # mac os x
# alias ls='ls --color=auto -h'
alias l='ls -la'
alias history='fc -l 1'

alias ..='cd ..'
alias cd..='cd ..'
alias cd...='cd ../..'

# Env vars
export COLORTERM=yes
export CC=gcc
export PAGER="less"
export EDITOR="vim"
export LESS="-R"

# Go specific env vars
export GOPATH=$HOME/go
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH="/usr/local/sbin:$PATH"

# History
HISTSIZE=1500
HISTFILE="${HOME}/.zshistory"
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups # ignore duplicated entries
setopt hist_ignore_space #ignore space

# Extended globbing
setopt extendedglob

# Key bindnings
bindkey -e
# Option-Right
bindkey '\e\e[C' forward-word
# Option-Left
bindkey '\e\e[D' backward-word

# Completion
autoload -U compinit; compinit
setopt shwordsplit
setopt auto_name_dirs

autoload -U promptinit; promptinit
autoload -U colors; colors

# PROMPT
SPACESHIP_PROMPT_ORDER=(
  time
  user
  host
  dir
  git
  line_sep
  char
)

SPACESHIP_TIME_SHOW=true

# Set Spaceship ZSH as a prompt
prompt spaceship

# Appearance
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=5
zstyle ':completion:*' prompt '%e'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

# Custom functions
# cool custom function - http://dev.gentoo.org/~steev/files/zshrc
extract() {
   if [[ -z "$1" ]] ; then
      print -P "usage: \e[1;36mextract\e[1;0m < filename >"
      print -P "       Extract the file specified based on the extension"
   elif [[ -f $1 ]] ; then
      case ${(L)1} in
         *.tar.bz2)  tar -jxvf $1	;;
         *.tar.gz)   tar -zxvf $1	;;
         *.bz2)      bunzip2 $1	   ;;
         *.gz)       gunzip $1	   ;;
         *.jar)      unzip $1       ;;
         *.rar)      unrar x $1	   ;;
         *.tar)      tar -xvf $1	   ;;
         *.tbz2)     tar -jxvf $1	;;
         *.tgz)      tar -zxvf $1	;;
         *.zip)      unzip $1	      ;;
         *.Z)        uncompress $1	;;
         *)          echo "Unable to extract '$1' :: Unknown extension"
      esac
   else
      echo "File ('$1') does not exist!"
   fi
}
