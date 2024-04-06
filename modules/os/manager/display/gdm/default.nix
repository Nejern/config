{ lib, config, ... }: {
  options = {
    module.manager.display.gdm.enable =
      lib.mkEnableOption "enables gdm display manager";
  };

  config = lib.mkIf config.module.manager.display.gdm.enable {
    services.xserver = {
      displayManager = {
        gdm = {
          enable = true;
        };
      };
    };
  };
}
