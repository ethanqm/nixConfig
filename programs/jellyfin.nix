{pkgs, lib, ...}:
{
  environment.systemPackages = (with pkgs; [
    # server
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
    # client
    jellyfin-desktop
    jellyfin-rpc # discord rich presence | #TODO - funky?
  ]);
  
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "user";
  };
}
