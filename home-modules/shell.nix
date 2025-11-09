{ config, pkgs, ...}:
let
  aliases = {
    ls = "ls --color=auto";
    grep = "grep --color=auto";
    cp = "cp -i";
    df = "df -h";
    free = "free -m";
    more = "less";
    fucking = "sudo";
    please = "sudo";
    susdo = "sudo";
    mansplain = "man";
    py = "python3";
    fuckoff = "pkill -9 -i";
    fo = "fuckoff";
    v = "nvim";
    f = "lf";
    define = "sdcv";
  };
  opt = [
    "autocd"
    "checkwinsize"
    "expand_aliases"
    "histappend"
  ];
in
{
  #environment.pathsToLink = [ "/share/bash-completion" ];
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = aliases;
    shellOptions = opt;
    bashrcExtra = ''
    
      # prompt:
      exstat() {
        if [[ $? == 0 ]]; then
          echo -e '\e[1;35m>'
        else
          echo -e '\e[1;31m!'
        fi
      }
PS1='\[\e[1;35m\]λ.\[\e[1;31m\]\u\[\e[1;33m\]@\[\e[1;32m\]\h \[\e[1;36m\]\W$(exstat)\$\[\e[0m\]'

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
    '';
  };
}
