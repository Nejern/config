{ pkgs, lib, config, ... }: {
  options = {
    module.gtk.theme.gruvbox.enable =
      lib.mkEnableOption "enables Gruvbox theme";
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
    dconf.settings."org/gnome/desktop/wm/preferences".button-layout = ":minimize,maximize,close";
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
