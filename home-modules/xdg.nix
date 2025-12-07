{ config, pkgs, lib, ...}:
let
  groupAssign = (types: apps:
    builtins.foldl' (acc: mimetype: {"${mimetype}" = apps;} // acc)
     {} types
  );
  mime = {
    audio = [
      "audio/3gpp2" "audio/aac"
      "audio/aacp" "audio/adpcm"
      "audio/aiff" "audio/x-aiff"
      "audio/basic" "audio/flac"
      "audio/midi" "audio/mp4"
      "audio/mp4a-latm" "audio/mpeg"
      "audio/ogg" "audio/opus"
      "audio/vnd.digital-winds" "audio/vnd.dts"
      "audio/vnd.dts.hd" "audio/vnd.lucent.voice"
      "audio/vnd.ms-playready.media.pya" "audio/vnd.nuera.ecelp4800"
      "audio/vnd.nuera.ecelp7470" "audio/vnd.nuera.ecelp9600"
      "audio/vnd.wav" "audio/wav"
      "audio/x-wav" "audio/vnd.wave"
      "audio/wave" "audio/x-pn-wav"
      "audio/webm" "audio/x-matroska"
      "audio/x-mpegurl" "audio/x-ms-wax"
      "audio/x-ms-wma" "audio/x-pn-realaudio"
      "audio/x-pn-realaudio-plugin"
    ];
    image = [
      "image/avif" "image/avif-sequence"
      "image/bmp" "image/cgm"
      "image/g3fax" "image/gif"
      "image/heic" "image/ief"
      "image/jpeg" "image/pjpeg"
      "image/png" "image/prs.btif"
      "image/svg+xml" "image/tiff"
      "image/vnd.adobe.photoshop" "image/vnd.djvu"
      "image/vnd.dwg" "image/vnd.dxf"
      "image/vnd.fastbidsheet" "image/vnd.fpx"
      "image/vnd.fst" "image/vnd.fujixerox.edmics-mmr"
      "image/vnd.fujixerox.edmics-rlc" "image/vnd.ms-modi"
      "image/vnd.net-fpx" "image/vnd.wap.wbmp"
      "image/vnd.xiff" "image/webp"
      "image/x-adobe-dng" "image/x-canon-cr2"
      "image/x-canon-crw" "image/x-cmu-raster"
      "image/x-cmx" "image/x-epson-erf"
      "image/x-freehand" "image/x-fuji-raf"
      "image/x-icns" "image/x-icon"
      "image/x-kodak-dcr" "image/x-kodak-k25"
      "image/x-kodak-kdc" "image/x-minolta-mrw"
      "image/x-nikon-nef" "image/x-olympus-orf"
      "image/x-panasonic-raw" "image/x-pcx"
      "image/x-pentax-pef" "image/x-pict"
      "image/x-portable-anymap" "image/x-portable-bitmap"
      "image/x-portable-graymap" "image/x-portable-pixmap"
      "image/x-rgb" "image/x-sigma-x3f"
      "image/x-sony-arw" "image/x-sony-sr2"
      "image/x-sony-srf" "image/x-xbitmap"
      "image/x-xpixmap" "image/x-xwindowdump"
    ];
    scripts = [
      "application/atom+xml" "application/atomcat+xml"
      "application/atomsvc+xml" "application/ccxml+xml"
      "application/davmount+xml" "application/ecmascript"
      "application/json" "application/lost+xml"
      "application/mathml+xml" "application/mediaservercontrol+xml"
      "application/oebps-package+xml" "application/patch-ops-error+xml"
      "application/pgp-signature" "application/pls+xml"
      "application/postscript" "application/rdf+xml"
      "application/reginfo+xml" "application/resource-lists+xml"
      "application/resource-lists-diff+xml" "application/rls-services+xml"
      "application/rsd+xml" "application/rss+xml"
      "application/rtf" "application/sbml+xml"
      "application/shf+xml" "application/smil+xml"
      "application/sparql-query" "application/sparql-results+xml"
      "application/srgs+xml" "application/ssml+xml"
      "application/vnd.adobe.xdp+xml" "application/vnd.apple.installer+xml"
      "application/vnd.chemdraw+xml" "application/vnd.criticaltools.wbs+xml"
      "application/vnd.eszigno3+xml" "application/vnd.handheld-entertainment+xml"
      "application/vnd.irepository.package+xml"
      "application/vnd.llamagraphics.life-balance.exchange+xml"
      "application/vnd.mozilla.xul+xml" "application/vnd.oma.dd2+xml"
      "application/vnd.solent.sdkm+xml" "application/vnd.uoml+xml"
      "application/vnd.zzazz.deck+xml" "application/voicexml+xml"
      "application/wsdl+xml" "application/wspolicy+xml"
      "application/x-csh" "application/x-sh"
      "application/x-shellscript" "application/xenc+xml"
      "application/xhtml+xml" "application/xml"
      "application/xml-dtd" "application/xop+xml"
      "application/xslt+xml" "application/xspf+xml"
      "application/xv+xml" "application/yaml"
    ];
    text = [
      "text/calendar" "text/css"
      "text/csv" "text/html"
      "text/javascript" "text/markdown"
      "text/mathml" "text/plain"
      "text/prs.lines.tag" "text/richtext"
      "text/sgml" "text/tab-separated-values"
      "text/troff" "text/uri-list"
      "text/vnd.curl" "text/vnd.curl.dcurl"
      "text/vnd.curl.mcurl" "text/vnd.curl.scurl"
      "text/vnd.fly" "text/vnd.fmi.flexstor"
      "text/vnd.graphviz" "text/vnd.in3d.3dml"
      "text/vnd.in3d.spot" "text/vnd.sun.j2me.app-descriptor"
      "text/vnd.wap.si" "text/vnd.wap.sl"
      "text/vnd.wap.wml" "text/vnd.wap.wmlscript"
      "text/x-asm" "text/x-c"
      "text/x-fortran" "text/x-java-source"
      "text/x-pascal" "text/x-python"
      "text/x-setext" "text/x-uuencode"
      "text/x-vcalendar" "text/x-vcard"
    ];
    video = [
      "video/3gpp" "video/3gpp2"
      "video/h261" "video/h263"
      "video/h264" "video/jpeg"
      "video/jpm" "video/mj2"
      "video/mp2t" "video/mp4"
      "video/mpeg" "video/ogg"
      "video/quicktime" "video/vnd.fvt"
      "video/vnd.mpegurl" "video/vnd.ms-playready.media.pyv"
      "video/vnd.vivo" "video/webm"
      "video/x-f4v" "video/x-fli"
      "video/x-flv" "video/x-m4v"
      "video/x-matroska" "video/x-ms-asf"
      "video/x-ms-wm" "video/x-ms-wmv"
      "video/x-ms-wmx" "video/x-ms-wvx"
      "video/x-msvideo" "video/x-sgi-movie"
      "video/x-ogm+ogg" "video/x-theora+ogg"
    ];
  };
in
{
  xdg = {
    enable = true;
    portal = {
      enable = true;
      xdgOpenUsePortal=true;
      extraPortals = with pkgs; [
        #xdg-desktop-portal-hyprland
        kdePackages.xdg-desktop-portal-kde
      ];
    config = {
      common = {
        default = [ "hyprland" "kde" ];
          "org.freedesktop.impl.portal.FileChooser" = ["kde"];
          #"org.freedesktop.portal.FileChooser" = ["dolphin"];
        };
      };
    };
    mime.enable = true;
    mimeApps = {
      enable = true;
      # override with associations.{added,removed}
      defaultApplications =
        groupAssign mime.video [ "mpv.desktop" "vlc.desktop" ] //
        groupAssign mime.audio [ "mpv.desktop" "vlc.desktop" ] //
        groupAssign mime.image [ "org.kde.gwenview.desktop" ] //
        groupAssign (mime.text ++ mime.scripts) [ "vim.desktop" ] //
        {
          "application/x-bittorrent" = [ "com.qbittorrent.Bittorrent.desktop" ];
          "application/pdf" = [ "org.kde.okular.desktop" ];
          # URIs
          "x-scheme-handler/https" = [ "firefox.desktop" ];
          "x-scheme-handler/http" = [ "firefox.desktop" ];
          "x-scheme-handler/magnet" = [ "com.qbittorrent.Bittorrent.desktop" ];
        }
      ;
    };
    userDirs.createDirectories = true;
    desktopEntries = {
      vim = {
        name = "Vim";
        terminal = true;
          # always opens new term...
          ## default term; tmux?
        exec = "kitty vim %F";
        type = "Application";
        mimeType = mime.text;
      };
      hakuneko = {
        name = "Hakuneko [temp fix]";
        type = "Application";
        exec = "hakuneko --no-sandbox"; # fix crash on launch 07 Dec 2025
      };
    };
  };
}
