{config, pkgs, ...}:
{
  programs.lf = {
    enable = true;
    previewer = {
      keybinding = "i";
      #source = pkgs.writeShellScript "lfpreview.sh" ''
      #  notify-send "${pkgs.ranger}/share/doc/ranger/config/scope.sh"
      #  ${pkgs.ranger}/share/doc/ranger/config/scope.sh "''${1}""''${2}""''${3}" "" "" || true
      #''; ## currently broken sad

      source = pkgs.writeShellScript "lfpreview.sh" ''
        #!/usr/bin/env bash

        case "$(xdg-mime query filetype "$1")" in
          text/*) cat "$1";;
          image/*) exiftool "$1";;
          video/*) echo "$1";;
          application/json) cat "$1";;
          application/toml) cat "$1";;
          application/yaml) cat "$1";;
          application/xml) cat "$1";;
          application/x-shellscript) cat "$1";;
          application/x-csh) cat "$1";;
          application/x-fishscript) cat "$1";;
          application/x-powershell) cat "$1";;
          application/x-bat) cat "$1";;
          application/x-gdscript) cat "$1";;
          application/x-executable) readelf -h "$1";;
          application/x-bittorrent) transmission-show "$1" | sed '/Privacy/,/FILES/{//!d;s/FILES//}';;
          application/vnd.appimage) readelf -h "$1";;
          application/vnd.debian.binary-package) (dpkg-deb -I "$1" && dpkg-deb -c "$1");;
          application/vnd.android.package-archive) unzip -l "$1";; # could do better
          application/zip) als "$1";;
          application/x-zstd-compressed-tar) als "$1";;
          application/vnd.comicbook*) als "$1";; # not working
          application/vnd.epub+zip) als "$1";; # not working
          application/vnd.rar) als "$1";;
          application/vnd.gzip) als "$1";;
          application/gzip) als "$1";;
          application/x-compressed-tar) als "$1";;
          application/x-7z-compressed) als "$1";;
          *) xdg-mime query filetype "$1";;
        esac
      '';
    };
  };
}
