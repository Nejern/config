{ lib, ... }: {
  imports = [
    ./git
    ./firefox
    ./thunderbird

    ./terminals/alacritty
    ./shells/zsh
  ];

  # Programs
  module.program.git.enable = lib.mkDefault false;
  module.program.firefox.enable = lib.mkDefault false;
  module.program.thunderbird.enable = lib.mkDefault false;

  ## Terminals
  module.program.terminal.alacritty.enable = lib.mkDefault false;

  ## Shells
  module.program.shell.zsh = {
    enable = lib.mkDefault false;
    omz.enable = lib.mkDefault true;
    p10k.enable = lib.mkDefault true;
    vi-mode.enable = lib.mkDefault true;
  };
}
