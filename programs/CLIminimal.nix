{pkgs, ...}: {
  environment.systemPackages = (with pkgs; [
      vim neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      tmux # terminal multiplexer
      wget # download from url
      git gh glab git-credential-oauth # source control
      bash-completion # tab-completion upgrade (?)

      pciutils
      usbutils
    
      htop btop # system monitoring
      fastfetch # neofetch replacement

      #powertop # INTEL! power monitoring
      ryzen-monitor-ng # AMD! power monitoring

      avahi # zeroconf mDNS for hostname local access

      bc # basic calculator

      ffmpeg # media converter
      yt-dlp # youtube downloader
      tree   # show directory tree
      nix-tree # show nix profile and dependencies structure
      file # file type
      lf #file tui
      ranger # ${pkg.ranger}/share/doc/ranger/config/scope.sh is nice but broken in lf
      rename # better than util-linux | supports regex s//g etc
      xdg-utils # mime-type tools
      xdg-desktop-portal
      kdePackages.xdg-desktop-portal-kde
      atool unzip unrar _7zz lzip lziprecover plzip tarlz p7zip # archive tools
      rarcrack # bruteforce?
      scrub # Gutmann file eraser
      foremost # file recovery
      fscrypt-experimental #encrypt directories | not finished
      dpkg # deb file stuff
      exiftool mediainfo mkvtoolnix mkvtoolnix-cli
      transmission_4 # torrents
      mu # email stuff
      pax-utils # elf info
      sqlite sqlite-utils
      jq fastgron # json tools
      pandoc xlsx2csv poppler-utils # fancy doc tools
      heh # hex editor
      fzf # fuzzy finder
      ripgrep # faster grep
      sdcv # terminal dictionary

      lm_sensors # cpu temp

      udiskie # auto-mount media

      base16-schemes # colorschemes

      kdePackages.kdeconnect-kde # linux/android wan connection
      megacmd # mega.nz cli ~ haven't really gotten working

      qrcp # send files over wifi by scanning QR code
      qrrs # terminal QR code
      ]);
}
