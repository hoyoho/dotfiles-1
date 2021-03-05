#!/bin/env zsh

eval "$(starship init zsh)"

if [ "$TMUX" = "" ]; then tmux; fi

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Aliases
alias vim='nvim'
alias ls='ls -G -h' # mac os x
# alias ls='ls --color=auto -h'
alias grep='grep --color=always'
alias l='ls -la'
alias k='kubectl'
alias history='fc -l 1'

alias ..='cd ..'
alias cd..='cd ..'
alias cd...='cd ../..'

# Env vars
export CC=gcc
export PAGER="less"
export EDITOR="nvim"
export LESS="-R"
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
# kudos http://dev.gentoo.org/~steev/files/zshrc
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# -l '.? ' will omit binary files
export FZF_DEFAULT_COMMAND="rg --files --hidden --smart-case --follow --glob \
\!.git/\* 2> /dev/null"

### Search a file with fzf and then open it in an editor ###
# kudos https://github.com/aenda/dotfiles/blob/master/zsh/environment.zsh
__fsel() {
  local cmd="${FZF_DEFAULT_COMMAND}"
  setopt localoptions pipefail 2> /dev/null
  eval "$cmd" | FZF_DEFAULT_OPTS="--height 70% --reverse $FZF_DEFAULT_OPTS" \
  $(echo "fzf") -m "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}

fzf_then_open_in_editor() {
    file="$(__fsel)"
    file_no_whitespace="$(echo -e "${file}" | tr -d '[:space:]')"
    if [ -n "$file_no_whitespace" ]; then
    # Use the default editor if it's defined, default nvim
        ${EDITOR:-nvim} "${file_no_whitespace}"
    fi;
    zle accept-line
}
zle -N fzf_then_open_in_editor
bindkey "^O" fzf_then_open_in_editor

