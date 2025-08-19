{ config, pkgs, ... }:
{
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

	# https://wiki.hyprland.org/Configuring/Variables/#animations
	animations = {
	    enabled = "yes";#, please :)

    # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

	    bezier = [
	      "easeOutQuint,0.23,1,0.32,1"
	      "easeInOutCubic,0.65,0.05,0.36,1"
	      "linear,0,0,1,1"
	      "almostLinear,0.5,0.5,0.75,1.0"
	      "quick,0.15,0,0.1,1"
	    ];

    animation = [
      "global, 1, 10, default"
      "border, 1, 5.39, easeOutQuint"
      "windows, 1, 4.79, easeOutQuint"
      "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
      "windowsOut, 1, 1.49, linear, popin 87%"
      "fadeIn, 1, 1.73, almostLinear"
      "fadeOut, 1, 1.46, almostLinear"
      "fade, 1, 3.03, quick"
      "layers, 1, 3.81, easeOutQuint"
      "layersIn, 1, 4, easeOutQuint, fade"
      "layersOut, 1, 1.5, linear, fade"
      "fadeLayersIn, 1, 1.79, almostLinear"
      "fadeLayersOut, 1, 1.39, almostLinear"
      "workspaces, 1, 1.94, almostLinear, fade"
      "workspacesIn, 1, 1.21, almostLinear, fade"
      "workspacesOut, 1, 1.94, almostLinear, fade"
     ];
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
	"$mod, P, pseudo, # dwindle"
	"$mod, J, togglesplit, # dwindle"
	# Move focus with mainMod + arrow keys
	"$mod, left, movefocus, l"
	"$mod, right, movefocus, r"
	"$mod, up, movefocus, u"
	"$mod, down, movefocus, d"
	# Move active window to a workspace with mainMod + SHIFT + [0-9]
	"$mod SHIFT, 1, movetoworkspace, 1"
	"$mod SHIFT, 2, movetoworkspace, 2"
	"$mod SHIFT, 3, movetoworkspace, 3"
	"$mod SHIFT, 4, movetoworkspace, 4"
	"$mod SHIFT, 5, movetoworkspace, 5"
	"$mod SHIFT, 6, movetoworkspace, 6"
	"$mod SHIFT, 7, movetoworkspace, 7"
	"$mod SHIFT, 8, movetoworkspace, 8"
	"$mod SHIFT, 9, movetoworkspace, 9"
	"$mod SHIFT, 0, movetoworkspace, 10"
	# Example special workspace (scratchpad)
	"$mod, S, togglespecialworkspace, magic"
	"$mod SHIFT, S, movetoworkspace, special:magic"
	# Scroll through existing workspaces with mainMod + scroll
	"$mod, mouse_down, workspace, e+1"
	"$mod, mouse_up, workspace, e-1"
      ];
      bindm = [
        "$mod, ALT, resizewindow"
        "$mod, SHIFT, movewindow"
      ];
      bindel = [
	# Laptop multimedia keys for volume and LCD brightness
	",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
	",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
	",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
	",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
	",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
	",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];
      bindl = [
	# Requires playerctl
	", XF86AudioNext, exec, playerctl next"
	", XF86AudioPause, exec, playerctl play-pause"
	", XF86AudioPlay, exec, playerctl play-pause"
	", XF86AudioPrev, exec, playerctl previous"

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

}
