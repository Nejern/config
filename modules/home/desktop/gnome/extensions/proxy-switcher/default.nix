{ pkgs, config, lib, ... }: {
  options = {
    module.desktop.gnome.extension.proxy-switcher.enable =
      lib.mkEnableOption "enables proxy-switcher gnome extension";
  };

  config = lib.mkIf config.module.desktop.gnome.extension.proxy-switcher.enable {
    home.packages = [
      pkgs.gnomeExtensions.proxy-switcher
    ];
    #dconf.settings = {
    #  "org/gnome/shell/extensions/proxy-switcher" = {
    #    countdown-timer = 0;
    #    duration-timer = 2;
    #    indicator-position-max = 3;
    #    screen-blank = "never";
    #    show-indicator = "only-active";
    #    #toggle-state = false;
    #    #user-enabled = false;
    #  };
    #};
  };
}
