{ config, pkgs, ... }:
{

  programs.kitty = {
    enable = true;
    #font = {
    #  name = "Inconsolata";
    #  size = 15;
    #};
    settings = {
      "wheel_scroll_multiplier" = 5.0;
      "touch_scroll_multiplier" = 1.0;

      # mouse selection
      "strip_trailing_spaces" = "never";
      "rectangle_select_modifiers" =  "ctrl+alt";
      "terminal_select_modifiers" = "shift"; #useful in tmux
      "select_by_word_characters" = "@-./_~?&=%+#";

      # performance
      "repaint_delay" = 16; # ms/frame
      "sync_to_monitor" = "yes";

      # alert notification
      "enable_audio_bell" = "no"; # mute error bell
      "window_alert_on_bell" = "yes"; # taskbar indicator

      # color scheme
      #"foreground" = "#dddddd";
      #"background" = "#000000";
      #"background_opacity" = 0.70;
      #"background_image" = "none"; # might use, must be PNG
      #"background_image_linear" = "no"; # linear scaling
      #"dynamic_background_opacity" = "yes"; # change without reload
      #"background_tint" = 0.0; # tint text background by bg col
      #"selection_foreground" = "#000000";
      #"selection_background" = "#fffacd";
      #"color0" =  "#000000"; #black
      #"color8" =  "#666666";
      #"color1" =  "#ff0000"; #red
      #"color9" =  "#990000";
      #"color2" =  "#00ff00"; #green
      #"color10" = "#009900";
      #"color3" =  "#ffff00"; #yellow
      #"color11" = "#999900";
      #"color4" =  "#0000ff"; #blue
      #"color12" = "#000099";
      #"color5" =  "#ff00ff"; #magenta
      #"color13" = "#990099";
      #"color6" =  "#00ffff"; #cyan
      #"color14" = "#009999";
      #"color7" =  "#ffffff"; #white
      #"color15" = "#999999";

      "cursor_trail" = 1; # animate cursor movement
      
      
      "shell" = "."; # user profile
      "editor" = "nvim"; # skip $VISUAL, #todo, make $EDITOR
      "update_check_interval" = 0; # disable checking for updates
      "term" = "xterm-kitty";
      "wayland_titlebar_color" = "system"; # server-side window decorations
    };
    keybindings = {
      "kitty_mod" = "ctrl+shift";
      
      "kitty_mod+c" = "copy_to_clipboard";
      "kitty_mod+p" = "paste_from_clipboard";
      
      "kitty_mod+equal" = "change_font_size all +2.0";
      "kitty_mod+plus" = "change_font_size all +2.0";
      "kitty_mod+kp_add" = "change_font_size all +2.0";
      "kitty_mod+minus" = "change_font_size all -2.0";
      "kitty_mod+kp_subtract" = "change_font_size all -2.0";

      # emoji etc
      "kitty_mod+u" = "kitten unicode_input";

      # transparency
      "kitty_mod+a>1" = "set_background_opacity 0.1";
      "kitty_mod+a>2" = "set_background_opacity 0.2";
      "kitty_mod+a>3" = "set_background_opacity 0.3";
      "kitty_mod+a>4" = "set_background_opacity 0.4";
      "kitty_mod+a>5" = "set_background_opacity 0.5";
      "kitty_mod+a>6" = "set_background_opacity 0.6";
      "kitty_mod+a>7" = "set_background_opacity 0.7";
      "kitty_mod+a>8" = "set_background_opacity 0.8";
      "kitty_mod+a>9" = "set_background_opacity 0.9";
      "kitty_mod+a>0" = "set_background_opacity 1.0";

    };
  };
}
