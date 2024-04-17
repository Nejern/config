{ pkgs, config, lib, ... }: {
  options = {
    module.program.shell.zsh.enable =
      lib.mkEnableOption "enables zsh";
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
          name = "p10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "p10k-config";
          src = ./p10k-config;
          file = "p10k.zsh";
        }
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
      ];

      # Oh My Zsh
      #oh-my-zsh = {
      #  enable = true;
      #  plugins = [
      #    "rust"
      #    "colored-man-pages"
      #    "vi-mode"
      #    "rust"
      #    "docker-compose"
      #  ];
      #};
    };
  };
}
