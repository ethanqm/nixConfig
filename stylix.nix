{ pkgs, config, ... }:
{
  stylix = {
    enable = true;
    # Check: https://tinted-theming.github.io/tinted-gallery/
    #        https://github.com/tinted-theming/schemes/tree/spec-0.11/base16
    # I like:
    # selenized-[light|dark]
    # atelier seaside (dark)
    base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-seaside.yaml";
    image = ./home-modules/wallpapers/aesthetic-sailor-moon-3z3wzc7rf9fipos2.jpg;
  };
}
