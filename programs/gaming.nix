{ lib, config, pkgs, stable, ... }:
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
        # itch # brokey
        lutris
        radeontop vulkan-tools
        obs-studio
        protonup-ng
        prismlauncher ftb-app# minecraft
    ])
    ++ (with stable; [
      itch
    ]);
  };
}
