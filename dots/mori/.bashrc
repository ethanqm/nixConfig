    
      # prompt:
      exitprompt() {
        if [[ $? == 0 ]]; then
PS1='\[\e[1;35m\]λ.\[\e[1;31m\]\u\[\e[1;33m\]@\[\e[1;32m\]\h \[\e[1;36m\]\W\[\e[1;35m\]>\$\[\e[0m\]'
        else
PS1='\[\e[1;35m\]λ.\[\e[1;31m\]\u\[\e[1;33m\]@\[\e[1;32m\]\h \[\e[1;36m\]\W\[\e[1;31m\]!$?\$\[\e[0m\]'
        fi
      }
PROMPT_COMMAND=exitprompt
      ex ()
      {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1   ;;
            *.tar.gz)    tar xzf $1   ;;
            *.bz2)       bunzip2 $1   ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1    ;;
            *.tar)       tar xf $1    ;;
            *.tbz2)      tar xjf $1   ;;
            *.tgz)       tar xzf $1   ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1;;
            *.7z)        7z x $1      ;;
            *)           echo "'$1' cannot be extracted via ex()" ;;
          esac
        else
          echo "'$1' is not a valid file"
        fi
      }


# Commands that should be applied only for interactive shells.
[[ $- == *i* ]] || return

HISTFILESIZE=100000
HISTSIZE=10000

shopt -s autocd
shopt -s checkwinsize
shopt -s expand_aliases
shopt -s histappend

alias cp='cp -i'
alias define=sdcv
alias df='df -h'
alias f=lf
alias fo=fuckoff
alias free='free -m'
alias fucking=sudo
alias fuckoff='pkill -9 -i'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias gd='git diff'
alias gdt='git difftool'
alias gl='git reflog'
alias grep='grep --color=auto'
alias gs='git status'
alias ls='ls --color=auto'
alias lzip='lzip -k'
alias mansplain=man
alias more=less
alias please=sudo
alias plzip='plzip -k'
alias py=python3
alias susdo=sudo
alias v=nvim
alias vimdiff='nvim -d'

if [[ ! -v BASH_COMPLETION_VERSINFO ]]; then
  . "/nix/store/an1k68bpqj8sas0zcd3dq33pjkphkb8a-bash-completion-2.17.0/etc/profile.d/bash_completion.sh"
fi

if test -n "$KITTY_INSTALLATION_DIR"; then
  export KITTY_SHELL_INTEGRATION="no-rc"
  source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"
fi

