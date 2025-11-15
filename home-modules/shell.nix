{ config, pkgs, ...}:
let
  aliases = {
    lzip = "lzip -k";
    plzip = "plzip -k";
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
    gs = "git status";
    ga = "git add";
    gc = "git commit";
    gco = "git checkout";
    gd = "git diff";
    gdt = "git difftool";
    gl = "git reflog";
  };
  opt = [
    "autocd"
    "checkwinsize"
    "expand_aliases"
    "histappend"
  ];
in
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = aliases;
    shellOptions = opt;
    bashrcExtra = ''
    
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
    '';
  };
}
