{ pkgs, lib, config, ... }: {
  options = {
    module.manager.desktop.gnome.enable =
      lib.mkEnableOption "enables gnome";
  };

  config = lib.mkIf config.module.manager.desktop.gnome.enable {
    services.xserver = {
      enable = true;
      desktopManager = {
        xterm.enable = false;
        gnome = {
          enable = true;
        };
      };
    };

    xdg = {
      portal = {
        enable = true;
      };
    };

    #environment.sessionVariables = {
    #  NIXOS_OZONE_WL = "1";
    #};

    environment.systemPackages = with pkgs; [
      gnomeExtensions.appindicator
      gnome.gnome-tweaks
      wl-clipboard
      xclip
    ];

    services.udev.packages = [
      pkgs.gnome.gnome-settings-daemon
    ];
  };
}
