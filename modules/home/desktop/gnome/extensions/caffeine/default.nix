{ pkgs, config, lib, ... }: {
  options = {
    module.desktop.gnome.extension.caffeine.enable =
      lib.mkEnableOption "enables caffeine gnome extension";
  };

  config = lib.mkIf config.module.desktop.gnome.extension.caffeine.enable {
    home.packages = [
      pkgs.gnomeExtensions.caffeine
    ];
    dconf.settings = {
      "org/gnome/shell/extensions/caffeine" = {
        countdown-timer = 0;
        duration-timer = 2;
        indicator-position-max = 3;
        screen-blank = "never";
        show-indicator = "only-active";
        #toggle-state = false;
        #user-enabled = false;
      };
    };
  };
}
