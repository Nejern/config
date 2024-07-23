{ lib, ... }: {
  imports = [
    ./hyprland
    ./gnome
  ];

  module.manager.desktop.gnome.enable = lib.mkDefault false;
  module.manager.desktop.hyprland.enable = lib.mkDefault false;
}
