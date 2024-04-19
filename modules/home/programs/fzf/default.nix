{ lib, config, pkgs, ... }: {
  options = {
    module.program.fzf.enable =
      lib.mkEnableOption "enables fzf";
  };

  config = lib.mkIf config.module.program.fzf.enable {
    home.packages = [
      pkgs.fd
    ];
    programs.fzf = {
      enable = true;
      enableZshIntegration = config.module.program.shell.zsh.enable;
      changeDirWidgetCommand = "fd --type d";
      defaultCommand = "fd --type f";
      fileWidgetCommand = "fd --type f";
    };
  };
}
