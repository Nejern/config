{ pkgs, lib, config, ... }: {
  options = {
    module.program.terminal.kitty.enable =
      lib.mkEnableOption "enables kitty";
  };

  config = lib.mkIf config.module.program.terminal.kitty.enable {
    home.file.".config/kitty".source = ./config;
    home.packages = [ pkgs.kitty ];
    xdg.desktopEntries = {
      kitty = {
        type = "Application";
        name = "kitty";
        genericName = "Terminal emulator";
        comment = "Fast, feature-rich, GPU based terminal";
        exec = "env -u WAYLAND_DISPLAY kitty";
        startupNotify = true;
        icon = "kitty";
        categories = [ "System" "TerminalEmulator" ];
      };
    };
  };
}
