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
  module.desktop.gnome.settings.enable = lib.mkDefault true;

  # Keybindings
  module.desktop.gnome.keybindings.enable = lib.mkDefault true;

  # Extensions
  module.desktop.gnome.extension = {
    dash-to-dock.enable = lib.mkDefault true;
    clipboard-indicator.enable = lib.mkDefault true;
    gnome-ui-tune.enable = lib.mkDefault true;
    caffeine.enable = lib.mkDefault true;
    blur-my-shell.enable = lib.mkDefault false;
    vitals.enable = lib.mkDefault false;
    proxy-switcher.enable = lib.mkDefault false;
  };
}
