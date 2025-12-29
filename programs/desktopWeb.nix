{pkgs, ...}:{
  environment.systemPackages = (with pkgs; [
      # web
      firefox
      mullvad-vpn
      qbittorrent
      discord
      brave
  ]);
}
