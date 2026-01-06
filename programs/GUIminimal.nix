{pkgs, ...}:{
  environment.systemPackages = (with pkgs; [
      # terminal emulators
      kitty 
      #ghostty
      guake

      networkmanagerapplet  # wifi systray
      dunst libnotify       # desktop notifications
      wofi                  # menu/applauncher

      # file explorer
      kdePackages.dolphin
      #xfce.thunar

      ## image viewer
      kdePackages.gwenview libwebp libheif

      ## pdf
      kdePackages.okular
      
      # font display
      font-manager
  ]);
}
