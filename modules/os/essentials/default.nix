{ lib, ... }: {
  imports = [
    ./nix.nix
    ./locale.nix
    ./xserver.nix
  ];

  module.essential = {
    nix-settings.enable = lib.mkDefault true;
    locale.enable = lib.mkDefault true;
    xserver.enable = lib.mkDefault true;
    xserver.xkb.enable = lib.mkDefault true;
  };
}
