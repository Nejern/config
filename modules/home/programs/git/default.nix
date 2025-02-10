{ lib, config, ... }: {
  options = {
    module.program.git.enable =
      lib.mkEnableOption "enables git";
  };

  config = lib.mkIf config.module.program.git.enable {
    home.file.".gitconfig".source = ./.gitconfig;
    programs.git = {
      enable = true;
      lfs.enable = true;
    };
  };
}
