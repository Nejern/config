{ lib, config, ... }: {
  options = {
    module.program.virtualbox.enable =
      lib.mkEnableOption "enables virtualbox";
  };

  config = lib.mkIf config.module.program.virtualbox.enable {
    virtualisation.virtualbox = {
      host.enable = true;
      #host.enableExtensionPack = true;
      #guest.enable = true;
      #guest.x11 = true;
    };
  };
}
