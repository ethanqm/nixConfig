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

        easyeffects # audio effects

        ludusavi
        radeontop vulkan-tools
        obs-studio
        protonup-ng
        prismlauncher ftb-app# minecraft

        #zelda64recomp # Zelda Majora's Mask only rn
        arx-libertatis # arx fatalis

        runelite # runescape
        bolt-launcher # needed for runelite until jagex launcher works
        
    ])
    ++ (with stable; [
      itch
      lutris # now it's bloodie valkey
      dusklight # Zelda twilight princess recomp
    ]);

    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
      plugins = [ pkgs.obs-studio-plugins.droidcam-obs ];
    };
  };
}
