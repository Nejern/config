{ pkgs, lib, config, ... }: {
  options = {
    module.gtk.theme.gruvbox.enable =
      lib.mkEnableOption "enables Gruvbox theme";
    module.gtk.theme.gruvbox.extra-buttons.enable =
      lib.mkEnableOption "enables extra buttons";
  };

  config = lib.mkIf config.module.gtk.theme.gruvbox.enable {
    nixpkgs.overlays = [
      (final: prev: {
        mypackages = {
          gruvbox-icons = pkgs.callPackage ./icons.nix { };
          gruvbox-gtk-theme = pkgs.callPackage ./theme.nix { };
        };
      })
    ];
    dconf.settings."org/gnome/desktop/wm/preferences".button-layout = ":${if config.module.gtk.theme.gruvbox.extra-buttons.enable then "minimize,maximize," else ""}close";
    gtk = {
      enable = true;
      theme = {
        name = "Gruvbox-Pink-Dark";
        package = pkgs.mypackages.gruvbox-gtk-theme;
      };
      iconTheme = {
        name = "Gruvbox";
        package = pkgs.mypackages.gruvbox-icons;
      };
      gtk3.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
  };
}
