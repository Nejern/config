{ lib, ... }: {
  imports = [
    ./settings
    ./keybindings
    ./extensions/dash-to-dock
    ./extensions/clipboard-indicator
    ./extensions/gnome-ui-tune
    ./extensions/blur-my-shell
    ./extensions/vitals
    ./extensions/caffeine
    ./extensions/proxy-switcher
  ];

  # Settings
  module.desktop.gnome.settings.enable = lib.mkDefault false;

  # Keybindings
  module.desktop.gnome.keybindings.enable = lib.mkDefault false;

  # Extensions
  module.desktop.gnome.extension = {
    dash-to-dock.enable = lib.mkDefault false;
    clipboard-indicator.enable = lib.mkDefault false;
    gnome-ui-tune.enable = lib.mkDefault false;
    caffeine.enable = lib.mkDefault false;
    blur-my-shell.enable = lib.mkDefault false;
    vitals.enable = lib.mkDefault false;
    proxy-switcher.enable = lib.mkDefault false;
  };
}
