{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.module.desktop.hyprland.waybar.enable {
    home.packages = with pkgs; [
      helvum
      font-awesome
    ];

    home.file."./.config/waybar".source = ./config;
    programs.waybar = {
      enable = true;
    };
  };
}
