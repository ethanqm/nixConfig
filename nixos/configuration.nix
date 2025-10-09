# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      #./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #networking.hostName = "lapnix"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";
  networking.nameservers = [
    # Cloudflare DNS
    "1.1.1.1"
    "1.0.0.1"
    "2606:4700:4700::1111"
    "2606:4700:4700::1001"
  ];

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.user = {
    isNormalUser = true;
    description = "user";
    extraGroups = [ "networkmanager" "wheel" "boinc" ];
    packages = with pkgs; [
 
    ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    backupFileExtension = "backup";
    users = {
      "user" = import ../home.nix;
    };
  };

  # Install firefox.
  programs.firefox = {
    enable = true;
    # look more into this bc default won't
    # allow typing file path
    # https://nixos.wiki/wiki/Firefox
    #preferences = {
    #  "widget.use-xdg-desktop-portal.file-picker" = 1;
    #};
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git gh glab git-credential-oauth

    htop
    neofetch

    tree
    file
    lf #file tui
    ranger # ${pkg.ranger}/share/doc/ranger/config/scope.sh is nice but broken in lf
    xdg-utils # mime-type tools
    atool unzip unrar _7zz # archive tools
    dpkg # deb file stuff
    exiftool mediainfo
    transmission_4 # torrents
    mu # email stuff
    pax-utils # elf info
    sqlite

    # hyprland
    wayland xwayland
    hyprland wofi
    hyprshade
    hyprpaper
    hyprshot
    waybar 
    networkmanagerapplet
    dunst libnotify
    kitty
    guake
    playerctl # kb media keys
    brightnessctl # screen brightness keys

    # file explorer
    kdePackages.dolphin
    xfce.thunar
    ## image viewer
    kdePackages.gwenview libwebp libheif

    # media
    vlc mpv ffmpeg
    youtube-music
    yt-dlp
    hakuneko # dl + read: manga + comic

    # wlan connect
    kdePackages.kdeconnect-kde

    obsidian # note taking

    # editing
    audacity
    krita
    inkscape
    davinci-resolve # todo: https://nixos.wiki/wiki/DaVinci_Resolve
    blender

    # dev
    python314
    nodejs_24 bun
    zig zls
    gdb lldb
    ghidra-bin
    nixd # lsp

    # web
    firefox 
    mullvad-vpn
    qbittorrent
    discord
    brave

    # gaming
    steam wine 
    itch
    lutris
    radeontop
    obs-studio
    protonup

    #compute
    boinc

    # work
    microsoft-edge
    zoom-us
  ];
  nix.extraOptions = ''
     keep-outputs = true
     keep-derivations = true
  ''; # don't gc build components
  environment.sessionVariables = {
    EDITOR = "vim";
    BROWSER = "firefox";
    FILE_BROWSER = "dolphin";
    MENU = "wofi --show drun";
    TERM = "kitty";
  };

  #home-manager standalone
  nix.settings.allowed-users = [ "user" ];
  nix.settings.experimental-features = ["nix-command" "flakes" ];

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.waybar = {
    enable = true;
  };
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.noto
    nerd-fonts.hack
    nerd-fonts.ubuntu
    nerd-fonts.inconsolata
    #nerd-fonts.mplus
  ];


  programs.steam = {
    enable = true;
  };
  hardware = {
    graphics = {
      enable = true;
    };
  };

  programs.kdeconnect.enable = true;
  programs.nix-ld.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;
   programs.ssh.startAgent = true;

   # compute boinc
   services.boinc = {
     enable = true;
   };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
