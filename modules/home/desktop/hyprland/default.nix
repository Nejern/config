{ config, lib, pkgs, ... }: {
  options = {
    module.desktop.hyprland.settings.enable =
      lib.mkEnableOption "enables hyprland settings";
  };

  config = lib.mkIf config.module.desktop.hyprland.settings.enable {
    #home.packages = with pkgs; [
    #  wofi
    #];
    wayland.windowManager.hyprland.enable = true;
    wayland.windowManager.hyprland.settings = {
      "$mod" = "SUPER";
      bind =
        [
          "$mod, X, exec, kitty"
          "$mod, B, exec, firefox-developer-edition"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
          builtins.concatLists (builtins.genList
            (
              x:
              let
                ws =
                  let
                    c = (x + 1) / 10;
                  in
                  builtins.toString (x + 1 - (c * 10));
              in
              [
                "$mod, ${ws}, workspace, ${toString (x + 1)}"
                "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
              ]
            )
            10)
        );
    };
  };
}
