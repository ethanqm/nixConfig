{config, pkgs, ...}:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    clock24 = true;
    plugins = with pkgs; with tmuxPlugins; [
      resurrect
      continuum
    ];
    extraConfig = ''
      # fix scrollwheel in LESS / man
      # https://github.com/tmux/tmux/issues/1320#issuecomment-381952082
      bind-key -T root WheelUpPane \
  if-shell -Ft= '#{?mouse_any_flag,1,#{pane_in_mode}}' \
    'send -Mt=' \
    'if-shell -t= "#{?alternate_on,true,false} || echo \"#{tmux_commands_with_legacy_scroll}\" | grep -q \"#{pane_current_command}\"" \
      "send -t= Up Up Up" "copy-mode -et="'

      bind-key -T root WheelDownPane \
  if-shell -Ft = '#{?pane_in_mode,1,#{mouse_any_flag}}' \
    'send -Mt=' \
    'if-shell -t= "#{?alternate_on,true,false} || echo \"#{tmux_commands_with_legacy_scroll}\" | grep -q \"#{pane_current_command}\"" \
      "send -t= Down Down Down" "send -Mt="'

      # no holes in window count
      set -g renumber-windows on
      # keep first window at left hand
      set -g base-index 1
      set -g pane-base-index 1

      ########################
      # Plugin After
      ########################
      # enable continuum
      set -g @continuum-restore 'on'
      # enable systemd service
      set -g @continuum-boot 'on' #broken on NixOS :/
    '';
  };
}
