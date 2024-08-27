{ lib, config, pkgs, ... }: {
  options = {
    module.program.thunderbird.enable =
      lib.mkEnableOption "enables thunderbird";
  };

  config = lib.mkIf config.module.program.thunderbird.enable {
    home.packages = with pkgs; [
      thunderbird
    ];
  };
}
