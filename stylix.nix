{ pkgs, config, lib, ... }:
{
  stylix = {
    enable = true;
    # wallpaper
    image = ./home-modules/wallpapers/aesthetic-sailor-moon-3z3wzc7rf9fipos2.jpg;
    # Check: https://tinted-theming.github.io/tinted-gallery/
    #        https://github.com/tinted-theming/schemes/tree/spec-0.11/base16
    # I like:
    # selenized-[light|dark]
    # atelier seaside (dark)
    base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-seaside.yaml";
    opacity = {
      applications = 1.0;
      terminal = 0.9;
      desktop = 1.0;
      popups = 1.0;
    };

    fonts = {
      sizes = {
        applications = 10;
        terminal = 12;
        desktop = 10;
        popups = 10;
      };
      # fc-list | grep for names
      #monospace = {
      #  package = pkgs.nerd-fonts.bigblue-terminal;
      #  name = "BigBlueTermPlus Nerd Font";
      #};
      monospace = { 
        package = pkgs.nerd-fonts.zed-mono;
        name = "ZedMono Nerd Font Mono";
      };
    };

  };
}
