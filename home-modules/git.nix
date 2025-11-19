{ config, pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    settings =  {
      user = {
        name = "ethanqm";
        email = "102937457+ethanqm@users.noreply.github.com";
      };
      init.defaultBranch = "main";

      credential = {
        helper = [ "cache --timeout 21600"  "oauth" ];
      };

      diff.tool = "vimdiff";
      difftool.prompt = false;
    };
  };
}
