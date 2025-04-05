{ lib, config, pkgs, ... }: {
  options = {
    module.program.brave.enable =
      lib.mkEnableOption "enables brave";
  };

  config = lib.mkIf config.module.program.brave.enable {
    home.packages = [
      pkgs.brave
    ];
  };
}
