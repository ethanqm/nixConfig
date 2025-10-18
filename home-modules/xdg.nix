{ config, pkgs, lib, ...}:
{
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      kdePackages.xdg-desktop-portal-kde
    ];
    config = {
      common = {
        default = [ "hyprland" "kde" ];
        "org.freedesktop.portal.FileChooser" = ["dolphin"];
      };
    };
  };
}
