{pkgs, ...}:{
  environment.systemPackages = (with pkgs; [
      # terminal emulators
      kitty 
      #ghostty
      kdePackages.yakuake

      networkmanagerapplet  # wifi systray
      dunst libnotify       # desktop notifications
      wofi                  # menu/applauncher

      # file explorer
      kdePackages.dolphin
      #xfce.thunar

      ## image viewer
      libwebp libheif 
      kdePackages.gwenview 
      photoqt
      

      ## pdf
      kdePackages.okular
      
      # font display
      font-manager
  ]);
}
