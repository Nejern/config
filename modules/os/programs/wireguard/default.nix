{ lib, config, pkgs, ... }: {
  options = {
    module.program.wireguard.enable =
      lib.mkEnableOption "enables wireguard";
  };

  config = lib.mkIf config.module.program.wireguard.enable {
    environment.systemPackages = [ pkgs.wireguard-tools ];
  };
}
