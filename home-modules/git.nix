{ config, pkgs, lib, ... }:
{
  programs.git = {
    enable = true;
    userName = "ethanqm";
    userEmail = "102937457+ethanqm@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";

      credential = {
        helper = [ "cache --timeout 21600"  "oauth" ];
      };

      diff.tool = "vimdiff";
      difftool.prompt = false;
    };
  };
}
