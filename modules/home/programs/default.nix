{ lib, ... }: {
  imports = [
    ./fzf
    ./git
    ./firefox
    ./brave
    ./thunderbird
    ./k9s

    ./terminals/alacritty
    ./terminals/kitty
    ./shells/zsh
  ];

  # Programs
  module.program = {
    fzf.enable = lib.mkDefault true;
    git.enable = lib.mkDefault false;
    firefox.enable = lib.mkDefault false;
    brave.enable = lib.mkDefault false;
    thunderbird.enable = lib.mkDefault false;
    k9s.enable = lib.mkDefault false;
    ## Terminals
    terminal = {
      alacritty.enable = lib.mkDefault false;
      kitty.enable = lib.mkDefault false;
    };
    ## Shells
    shell.zsh = {
      enable = lib.mkDefault false;
      omz.enable = lib.mkDefault true;
      p10k.enable = lib.mkDefault true;
      vi-mode.enable = lib.mkDefault true;
    };
  };
}
