{pkgs, lib, ...}:
{
  environment.systemPackages = (with pkgs; [
    # server
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    jellyfin-mpv-shim
    # client
    jellyfin-desktop
    jellyfin-rpc # discord rich presence | #TODO - funky?
  ]);
  
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "user";
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
      ExecStart= ''${pkgs.jellyfin-rpc}/bin/jellyfin-rpc'';
      #Restart="on-failure";
    };
  };
}
