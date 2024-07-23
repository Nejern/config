{ pkgs, lib, config, ... }: {
  options = {
    module.manager.desktop.hyprland.enable =
      lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.module.manager.desktop.hyprland.enable {
    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    programs.hyprland.enable = true;
  };
}
