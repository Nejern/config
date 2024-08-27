{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.module.desktop.hyprland.waybar.enable {
    home.file."./.config/wofi".source = ./config;
    programs.wofi = {
      enable = true;
    };
  };
}
