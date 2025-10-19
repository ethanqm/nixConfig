{ config, pkgs, lib, ...}:
{
  xdg =  {
    enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        #xdg-desktop-portal-hyprland
        kdePackages.xdg-desktop-portal-kde
      ];
      config = {
        common = {
          default = [ "hyprland" "kde" ];
          "org.freedesktop.impl.portal.FileChooser" = ["kde"];
          #"org.freedesktop.portal.FileChooser" = ["dolphin"];
        };
      };
    };
    mime.enable = true;
    mimeApps = {
      enable = true;
    };
    userDirs.createDirectories = true;
  };
}
