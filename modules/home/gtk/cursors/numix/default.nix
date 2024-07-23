{ pkgs, lib, config, ... }: {
  options = {
    module.gtk.cursor.numix.enable =
      lib.mkEnableOption "enables Gruvbox theme";
  };

  config = lib.mkIf config.module.gtk.cursor.numix.enable {
    home.pointerCursor = {
      gtk.enable = true;
      #x11.enable = true;
      package = pkgs.numix-cursor-theme;
      name = "Numix-Cursor";
      size = 16;
    };
    gtk = {
      enable = true;
    };
  };
}
