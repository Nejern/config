{ pkgs, lib, config, inputs, ... }: {
  options = {
    module.manager.desktop.hyprland.enable =
      lib.mkEnableOption "enables hyprland";
  };

  config = lib.mkIf config.module.manager.desktop.hyprland.enable {
    environment.systemPackages = with pkgs; [
      wl-clipboard
      xclip
    ];

    services.upower.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    hardware.graphics = {
      package = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.mesa.drivers;
      package32 = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system}.pkgsi686Linux.mesa.drivers;
    };

    programs = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };
    };

    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };

    xdg.portal = {
      enable = true;
      xdgOpenUsePortal = true;
      config = {
        hyprland.default = [ "hyprland" "gtk" ];
      };
      extraPortals = [
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
    };
  };
}
