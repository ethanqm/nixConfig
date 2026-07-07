{pkgs, stable, ...}:{
  environment.systemPackages = (with pkgs; [
      # web
      firefox # AI website creator ad in settings menu 🚮
      mullvad-vpn
      mullvad-browser
      qbittorrent
      discord
      brave
      megasync
      droidcam
  ])
  ++ (with stable; [
    librewolf # unstable unmaintained... 2026-06-26
  ]);
  
}
