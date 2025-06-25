{ config, lib, ... }: {
  config = lib.mkIf config.module.desktop.hyprland.mako.enable {
    services.mako = {
      enable = true;
      settings = {
        # Take a look at the mako manpage with the command:
        #   man 5 mako
        # To view all configuration options.

        # GLOBAL
        "max-history" = "100";
        "sort" = "-time";
        #"output" = "DP-2";

        # STYLE OPTIONS
        "font" = "Fantasque Sans Mono 11";
        "format" = "<b>%a ⏵</b> %s\\n%b";
        "width" = "300";
        "height" = "100";
        "margin" = "5";
        "padding" = "0,5,10";
        "border-size" = "2";
        "border-radius" = "15";
        "icons" = "1";
        "max-icon-size" = "24";
        "icon-location" = "right";
        #"markup" = "1";
        #"actions" = "1";
        #"history" = "1";
        #"text-alignment" = "center";
        "default-timeout" = "5000";
        "ignore-timeout" = "1";
        "max-visible" = "7";
        "layer" = "overlay";
        "anchor" = "top-right";
        "background-color" = "#3c3836";
        "border-color" = "#458588";
        #"text-color" = "#1e1e2e";
        #"background-color" = "#e7e7ec";
        #"border-color" = "#313244";
        "progress-color" = "over #458588";

        # BINDING OPTIONS
        "on-button-left" = "dismiss";
        "on-button-middle" = "none";
        "on-button-right" = "dismiss-all";
        "on-touch" = "dismiss";
        #"on-notify" = "exec mpv /usr/share/sounds/freedesktop/stereo/message.oga";

        # URGENCY
        "urgency=low" = {
          "border-color" = "#8ec07c";
          "default-timeout" = "3000";
        };

        "urgency=normal" = {
          "border-color" = "#d79921";
        };

        "urgency=high" = {
          "border-color" = "#cc241d";
          "default-timeout" = "0";
        };

        # CATEGORY
        "category=backlight" = {
          "anchor" = "center";
          "default-timeout" = "1500";
          "group-by" = "category";
          "format" = "";
        };

        "category=volume" = {
          "anchor" = "center";
          "default-timeout" = "1500";
          "group-by" = "category";
          "format" = "";
          "border-color" = "#458588";
        };

        #"category=mpd" = {
        #  "border-color" = "#f9e2af";
        #  "default-timeout" = "2000";
        #  "group-by" = "category";
        #  "format" = "";
        #  "border-color" = "#458588";
        #};

        # APPS
        #"app-name=lightcord" = {
        #  "border-color" = "#88c0d0";
        #};

        #"app-name=lightcord summary~=\"(.*(^| )orz|ORZ|sto|STO|otl|OTL( |$).*)\"" = {
        #  "invisible" = "1";
        #};

        # OTHER
        #"summary~=\"log-.*\"" = {
        #  "border-color" = "#a3be8c";
        #};

      };

    };
    home.file."./.config/mako/icons".source = ./icons;
  };
}
