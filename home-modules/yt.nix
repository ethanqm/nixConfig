{ config, pkgs, ... }:
{
  programs.yt-dlp = {
    enable = true;
    settings = {
      embed-thumbnail = true;
      embed-subs = true;
      embed-chapters = true;
      sub-langs = "all,-live_chat";
    };
  };
}
