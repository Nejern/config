{ pkgs, config, lib, ... }: {
  options = {
    module.program.shell.zsh.enable =
      lib.mkEnableOption "enables zsh";
    module.program.shell.zsh.p10k.enable =
      lib.mkEnableOption "enables zsh p10k";
    module.program.shell.zsh.omz.enable =
      lib.mkEnableOption "enables zsh omz";
    module.program.shell.zsh.vi-mode.enable =
      lib.mkEnableOption "enables zsh vi-mode";
  };

  config = lib.mkIf config.module.program.shell.zsh.enable {
    programs.zsh = {
      enable = true;

      # Options
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      # History
      history.size = 10000;
      history.path = "${config.xdg.dataHome}/zsh/history";

      # Plugins
      plugins = [
        {
          name = "zsh-nix-shell";
          file = "nix-shell.plugin.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "chisui";
            repo = "zsh-nix-shell";
            rev = "v0.8.0";
            sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
          };
        }
        (lib.mkIf config.module.program.shell.zsh.vi-mode.enable {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        })
        (lib.mkIf config.module.program.shell.zsh.p10k.enable {
          name = "p10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        })
        (lib.mkIf config.module.program.shell.zsh.p10k.enable {
          name = "p10k-config";
          src = ./p10k-config;
          file = "p10k.zsh";
        })
      ];

      # Oh My Zsh
      oh-my-zsh = {
        enable = config.module.program.shell.zsh.omz.enable;
        plugins = [
          "rust"
          "colored-man-pages"
          "docker-compose"
          "terraform"
        ];
      };
    };
  };
}
