{ lib, config, pkgs, ... }: {
  options = {
    module.program.k9s.enable =
      lib.mkEnableOption "enables k9s";
  };

  config = lib.mkIf config.module.program.k9s.enable {
    home.packages = with pkgs; [
      k9s
      popeye
    ];
    home.file.".config/k9s".source = ./config;
  };
}
