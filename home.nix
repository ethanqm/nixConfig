{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "user";
  home.homeDirectory = "/home/user";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    #fonts make waybar work
    #fira-code fira-code-symbols
    #font-awesome
    #liberation_ttf
    #mplus-outline-fonts.githubRelease
    #nerdfonts
    #noto-fonts notofonts-emoji
    #proggyfonts
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/user/etc/profile.d/hm-session-vars.sh
  #

  gtk = {
    enable = true;
  };

  #HYPRLAND
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # autostart
      exec-once = [
        "waybar &"
        "hyprpaper"
        "nm-applet --indicator"
        "dunst"
      ];
      # rice
      decoration = {
        rounding = 5;
        active_opacity = 1.0;
        inactive_opacity = 0.5;
        shadow = {
          enabled = true;
          range = 4;
          render_power = 1;
          color = "rgba(1a1a1aee)";         
        };
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 1.696;
        };
      };
      # hotkeys
      "$mod" = "super";
      bind = [
        "$mod, Q, exec, $TERM"
        "$mod, C, killactive"
        "$mod, M, exit"
        "$mod, F, exec, $FILE_BROWSER"
        "$mod, B, exec, $BROWSER"
        "$mod, SPACE, exec, $MENU"
        "$mod, V, togglefloating"
        "$mod, O, fullscreen, 1"
      ];
      bindm = [
        "$mod, ALT, resizewindow"
        "$mod, SHIFT, movewindow"
      ];
    };
  };
  programs.waybar.settings.main = {
    modules-right = [ "nm-applet" "clock" ];
  };

  services = {
    hyprpaper = {
      enable = true;
      settings = {
        preload = ["~/Pictures/aesthetic-sailor-moon-3z3wzc7rf9fipos2.jpg"];
        wallpaper = [", ~/Pictures/aesthetic-sailor-moon-3z3wzc7rf9fipos2.jpg"];
      };
    };
  };

  fonts.fontconfig.enable = true;

  programs.git = {
    enable = true;
    userName = "ethanqm";
    userEmail = "102937457+ethanqm@users.noreply.github.com";
    extraConfig = {
      init.defaultBranch = "main";
    };
  };

  # vim
  programs.vim = {
   enable = true;
   settings = {
     tabstop = 2;
     shiftwidth = 2;
     number = true;
     relativenumber = true;
     mouse = "a";
   };
   extraConfig = ''
     set syntax=true
     set clipboard+=unnamedplus
     set splitbelow splitright
     
     " sanskrit binds
     inoremap <C-k>.l ḷ
     inoremap <C-k>.r ṛ
     inoremap <C-k>.m ṃ
     inoremap <C-k>.n ṇ
     inoremap <C-k>.s ṣ
     inoremap <C-k>.t ṭ
     inoremap <C-k>.d ḍ
     inoremap <C-k>.h ḥ
     
     inoremap <C-k>.L Ḷ
     inoremap <C-k>.R Ṛ
     inoremap <C-k>.M Ṃ
     inoremap <C-k>.N Ṇ
     inoremap <C-k>.S Ṣ
     inoremap <C-k>.T Ṭ
     inoremap <C-k>.D Ḍ
     inoremap <C-k>.H Ḥ
   '';
  };


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
