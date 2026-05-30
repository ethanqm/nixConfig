{pkgs, stable, lib, ...}:
{
  environment.systemPackages = (with pkgs; [
  ]) ++ (with stable; [ # more up to date for some reason?
    # server
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    jellyfin-mpv-shim
    # client
    jellyfin-desktop
    jellyfin-rpc # discord rich presence
  ]);
  
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "user";
    package = stable.jellyfin; # more up to date 2026-05-30
  };
  
  # RPC doesn't install service
  # adapted from official github
  systemd.user.services.jellyfin-rpc = {
    enable = true;
    after = [ "network.target" ];
    wantedBy = [ "default.target" ];
    description = "jellyfin-RPC Service";
    serviceConfig = {
      Type = "simple";
      ExecStart= ''${stable.jellyfin-rpc}/bin/jellyfin-rpc'';
      #Restart="on-failure";
    };
  };
}
