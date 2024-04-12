{ lib, config, ... }: {
  options = {
    module.essential.xserver.enable =
      lib.mkEnableOption "enables xserver";
    module.essential.xserver.xkb.enable =
      lib.mkEnableOption "enables xserver xkb";
  };

  config = lib.mkIf config.module.essential.xserver.enable {
    services.xserver = {
      enable = true;
      xkb = lib.mkIf config.module.essential.xserver.xkb.enable {
        layout = "us,ru";
        options = "caps:escape_shifted_capslock";
      };
    };
  };
}
