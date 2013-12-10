#!/bin/zsh

# Aliases
alias ls='ls --color=auto -h'
alias l='ls -la'
alias grep='grep --color=auto'
alias cp='cp --reflink=auto'
alias history='fc -l 1'

alias ..='cd ..'
alias cd..='cd ..'
alias cd...='cd ../..'

# fun
alias please='sudo'

# vim fans united
alias :q="exit"
alias :wq="exit"

# colors everywhere
if type -p colordiff &> /dev/null ; then alias diff="colordiff" ; fi
if type -p colorcvs &> /dev/null ; then alias cvs="colorcvs" ; fi
if type -p colorgcc &> /dev/null ; then alias gcc="colorgcc" ; fi

# Env vars
export COLORTERM=yes
export CC=gcc
export PAGER="less"
export EDITOR="vim"
export LESS="-R"

# GNU Colors
[ -f /etc/DIR_COLORS ] && eval $(dircolors -b /etc/DIR_COLORS)
export ZLSCOLORS="${LS_COLORS}"

# Gentoo Dev settings
if [ $UID -ne 0 ]; then
	export ECHANGELOG_USER="Pavlos Ratis <dastergon@gentoo.org>"
	# KeyChain
	keychain --dir ~/.ssh/.keychain ~/.ssh/id_rsa
	source ~/.ssh/.keychain/$HOST-sh
fi

# Completion
autoload -U compinit; compinit
setopt auto_name_dirs

# Prompt and colors
autoload -U promptinit; promptinit
setopt prompt_subst
autoload -U colors; colors
prompt gentoo

# History
HISTSIZE=1500
HISTFILE="${HOME}/.zshistory"
SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups # ignore duplicated entries
setopt hist_ignore_space #ignore space

# Appearance
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Extended globbing
setopt extendedglob

# Key bindnings

# filter history by command
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward
 
# Custom functions 

# Git + zsh prompt ( https://gist.github.com/joshdick/4415470 )

# prompt
THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}["
THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"
THEME_GIT_PROMPT_CLEAN=""

# show git branch/tag, or name-rev if on detached head
parse_git_branch() {
  (command git symbolic-ref -q HEAD || command git name-rev --name-only --no-undefined --always HEAD) 2>/dev/null
}

# show red star if there are uncommitted changes
parse_git_dirty() {
  if command git diff-index --quiet HEAD 2> /dev/null; then
    echo "$THEME_GIT_PROMPT_CLEAN"
  else
    echo "$THEME_GIT_PROMPT_DIRTY"
  fi
}

# if in a git repo, show dirty indicator + git branch
git_custom_status() {
  local git_where="$(parse_git_branch)"
  [ -n "$git_where" ] && echo "$(parse_git_dirty)$THEME_GIT_PROMPT_PREFIX${git_where#(refs/heads/|tags/)}$THEME_GIT_PROMPT_SUFFIX"
}
# right-hand prompt
RPS1='$(git_custom_status) $EPS1'

# taken from oh-my-zsh
function zsh_stats() {
    history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n20
}

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

# thanks to hackernews
export MARKPATH=$HOME/.marks

function jump {
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}

function mark {
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}

function unmark {
    rm -i "$MARKPATH/$1"
}

function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

function _completemarks {
    reply=($(ls $MARKPATH))
}

compctl -K _completemarks jump
compctl -K _completemarks unmark
