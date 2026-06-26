{pkgs, stable, ...}:{
  environment.systemPackages = (with pkgs; [
      # web
      firefox # AI website creator ad in settings menu 🚮
      librewolf
      mullvad-vpn
      mullvad-browser
      qbittorrent
      discord
      brave
      megasync
      droidcam
  ]);
}
