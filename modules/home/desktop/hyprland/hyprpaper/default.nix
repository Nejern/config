{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.module.desktop.hyprland.hyprpaper.enable {
    home.packages = with pkgs; [
      hyprpaper
    ];
    home.file."./.config/hypr/hyprpaper.conf".source = ./hyprpaper.conf;
  };
}
