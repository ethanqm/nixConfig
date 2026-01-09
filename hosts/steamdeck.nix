{pkgs, ...}:
{
  #following https://chrastecky.dev/gaming/persistent-packages-on-steam-deck-using-nix
  home.username = "deck";
  home.homeDirectory = "/home/deck";

  targets.genericLinux.enable = true;

  programs.bash = {
    enable = true;
    initExtra = ''
      if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi

      export NIX_SHELL_PRESERVE_PROMPT=1
      if [[ -n "$IN_NIX_SHELL" ]]; then
        export PS1="$PS1(nix-shell) "
      fi
    '';
  };

  home.stateVersion = "25.11"; # don't change this even if you upgrade your channel in the future, this should stay the same as the version you first installed nix on

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;
  home.packages = (with pkgs; [
    nix-tree
    megasync
    megacmd
    arx-libertatis
  ]);
  services.megasync.enable = true;
}
