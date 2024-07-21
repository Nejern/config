{ lib, ... }: {
  imports = [
    ./fzf
    ./git
    ./firefox
    ./thunderbird
    ./k9s

    ./terminals/alacritty
    ./terminals/kitty
    ./shells/zsh
  ];

  # Programs
  module.program.fzf.enable = lib.mkDefault true;
  module.program.git.enable = lib.mkDefault false;
  module.program.firefox.enable = lib.mkDefault false;
  module.program.thunderbird.enable = lib.mkDefault false;
  module.program.k9s.enable = lib.mkDefault false;

  ## Terminals
  module.program.terminal.alacritty.enable = lib.mkDefault false;
  module.program.terminal.kitty.enable = lib.mkDefault false;

  ## Shells
  module.program.shell.zsh = {
    enable = lib.mkDefault false;
    omz.enable = lib.mkDefault true;
    p10k.enable = lib.mkDefault true;
    vi-mode.enable = lib.mkDefault true;
  };
}
