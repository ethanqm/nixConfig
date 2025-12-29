{ lib, config, pkgs, ... }:
{
  options = {
    gaming.enable = lib.mkEnableOption "Installs all gaming progs";
  };
  config = lib.mkIf config.gaming.enable {
    programs.steam = {
          enable = true;
        };
    environment.systemPackages = (with pkgs; [
        # gaming
        steam protontricks
        wine winetricks
        itch
        lutris
        radeontop vulkan-tools
        obs-studio
        protonup-ng
        prismlauncher ftb-app# minecraft
    ]);
  };
}
