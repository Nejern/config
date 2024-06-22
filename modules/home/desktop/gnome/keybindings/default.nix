{ config, lib, ... }: {
  options = {
    module.desktop.gnome.keybindings.enable =
      lib.mkEnableOption "enables gnome keybindings";
  };

  config = lib.mkIf config.module.desktop.gnome.keybindings.enable {
    dconf.settings = {
      "org/gnome/shell/keybindings" = {
        toggle-message-tray = [ ];
      };
      "org/gnome/desktop/wm/keybindings" = {
        close = [ "<Super>q" ];
        begin-move = [ "<Super>m" ];
        minimize = [ ];
        move-to-monitor-down = [ "<Shift><Super>j" ];
        move-to-monitor-left = [ "<Shift><Super>h" ];
        move-to-monitor-right = [ "<Shift><Super>l" ];
        move-to-monitor-up = [ "<Shift><Super>k" ];
        move-to-workspace-last = [ "<Shift><Alt><Super>k" ];
        move-to-workspace-left = [ "<Shift><Alt><Super>h" ];
        move-to-workspace-right = [ "<Shift><Alt><Super>l" ];
        switch-to-workspace-left = [ "<Alt><Super>h" ];
        switch-to-workspace-right = [ "<Alt><Super>l" ];
        toggle-fullscreen = [ "<Super>F11" ];
        toggle-maximized = [ "<Alt><Super>F11" ];
      };
      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left = [ "<Super>h" ];
        toggle-tiled-right = [ "<Super>l" ];
      };

      # Custom keybindings
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        ];
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>x";
        command = "xdg-terminal-exec";
        name = "Open Terminal";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Shift><Control><Alt>Delete";
        command = "gnome-session-quit --reboot";
        name = "Reboot";
      };
    };
  };
}
