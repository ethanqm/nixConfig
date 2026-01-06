{pkgs, ...}: {
  environment.systemPackages = (with pkgs; [
      vim neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      tmux
      wget
      git gh glab git-credential-oauth
      bash-completion

      htop btop
      fastfetch # neofetch replacement

      bc

      ffmpeg
      yt-dlp
      tree
      nix-tree
      file
      lf #file tui
      ranger # ${pkg.ranger}/share/doc/ranger/config/scope.sh is nice but broken in lf
      xdg-utils # mime-type tools
      xdg-desktop-portal
      kdePackages.xdg-desktop-portal-kde
      atool unzip unrar _7zz lzip lziprecover plzip tarlz # archive tools
      dpkg # deb file stuff
      exiftool mediainfo mkvtoolnix mkvtoolnix-cli
      transmission_4 # torrents
      mu # email stuff
      pax-utils # elf info
      sqlite sqlite-utils
      jq fastgron # json tools
      pandoc xlsx2csv poppler-utils # fancy doc tools
      heh # hex editor
      fzf
      sdcv # terminal dictionary

      lm_sensors

      udiskie # auto-mount media

      base16-schemes
      font-manager

      # wlan connect
      kdePackages.kdeconnect-kde
      megacmd # mega.nz cli
      qrcp # send files over wifi by scanning QR code
      qrrs # terminal QR code
      ]);
}
