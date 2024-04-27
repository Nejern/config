{ config, lib, ... }: {
  options = {
    module.desktop.gnome.settings.enable =
      lib.mkEnableOption "enables gnome settings";
  };

  config = lib.mkIf config.module.desktop.gnome.settings.enable {
    dconf.settings = {
      "/org/gnome/desktop/peripherals/touchpad" = {
        tap-to-click = true;
      };
      "org/gnome/desktop/wm/preferences" = {
        auto-raise = false;
        focus-mode = "sloppy";
        resize-with-right-button = false;
      };
      "org/gnome/mutter" = {
        dynamic-workspaces = true;
        edge-tiling = true;
      };
      "org/gnome/desktop/interface" = {
        enable-hot-corners = false;
      };
    };
  };
}
