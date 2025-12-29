{pkgs, ...}:{
  environment.systemPackages = (with pkgs; [
      # hyprland
      wayland xwayland
      hyprland
      hyprshade
      hyprpaper
      hyprshot
      waybar
      playerctl # kb media keys
      brightnessctl # screen brightness keys
      ddcutil
  ]);
}
