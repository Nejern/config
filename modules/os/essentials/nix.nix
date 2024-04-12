{ lib, config, ... }: {
  options = {
    module.essential.nix-settings.enable =
      lib.mkEnableOption "enables nix-settings";
  };

  config = lib.mkIf config.module.essential.nix-settings.enable {
    nix = {
      settings = {
        auto-optimise-store = true;
        experimental-features = [ "nix-command" "flakes" ];
      };
    };
  };
}
