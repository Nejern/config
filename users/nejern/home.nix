{ config, pkgs, username, ... }: {
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # Modules
  module = {
    # Programs
    program = {
      git.enable = true;
      # Terminal
      terminal.kitty.enable = true;
      # Shell
      shell.zsh.enable = true;
      # Browser
      firefox.enable = true;
      # Mail client
      thunderbird.enable = true;
      # K8s client
      k9s.enable = true;
    };

    # Gtk
    gtk = {
      theme.gruvbox.enable = true;
      cursor.numix.enable = true;
    };

    ## Desktop
    desktop = {
      # Hyprland
      hyprland = {
        enable = true;
        settings.enable = true;
        hyprpaper.enable = true;
        waybar.enable = true;
        mako.enable = true;
        wofi.enable = true;
        clipboard.enable = true;
      };
    };
  };

  home.packages = with pkgs; [
    # EDITOR
    neovim
    ## Etc
    ctags
    ripgrep

    # Compiler
    clang
    rustup

    # ls
    eza

    # k8s
    kubectl
    kubernetes-helm
    openlens

    # Misc
    vesktop
    telegram-desktop
    xdg-terminal-exec
    spotify
    insomnia
    jq
    unzip
    onlyoffice-bin_latest
    python312Packages.grip
    github-cli
    opentofu
    terraform
    terragrunt
    cmus
    obsidian
    qbittorrent
    nvtopPackages.full
    winbox
    traceroute
    dnsutils

    (pkgs.writeShellScriptBin "shell-colors" ''
      #!/usr/bin/env sh
      printf "|039| \033[39mDefault \033[m  |049| \033[49mDefault \033[m  |037| \033[37mLight gray \033[m     |047| \033[47mLight gray \033[m\n"
      printf "|030| \033[30mBlack \033[m    |040| \033[40mBlack \033[m    |090| \033[90mDark gray \033[m      |100| \033[100mDark gray \033[m\n"
      printf "|031| \033[31mRed \033[m      |041| \033[41mRed \033[m      |091| \033[91mLight red \033[m      |101| \033[101mLight red \033[m\n"
      printf "|032| \033[32mGreen \033[m    |042| \033[42mGreen \033[m    |092| \033[92mLight green \033[m    |102| \033[102mLight green \033[m\n"
      printf "|033| \033[33mYellow \033[m   |043| \033[43mYellow \033[m   |093| \033[93mLight yellow \033[m   |103| \033[103mLight yellow \033[m\n"
      printf "|034| \033[34mBlue \033[m     |044| \033[44mBlue \033[m     |094| \033[94mLight blue \033[m     |104| \033[104mLight blue \033[m\n"
      printf "|035| \033[35mMagenta \033[m  |045| \033[45mMagenta \033[m  |095| \033[95mLight magenta \033[m  |105| \033[105mLight magenta \033[m\n"
      printf "|036| \033[36mCyan \033[m     |046| \033[46mCyan \033[m     |096| \033[96mLight cyan \033[m     |106| \033[106mLight cyan \033[m\n"
    '')
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  ###
  # Shell
  ###
  home.shellAliases = {
    v = "nvim";

    # ls
    ls = "eza --color=auto";
    l = "eza -la";
    la = "eza -la";
    ll = "eza -l";
    lsa = "eza -la";

    # mkdir
    md = "mkdir -p";
  };

  ###
  # Home-manager
  ###
  programs.home-manager.enable = true;
  home.stateVersion = "23.11"; # Please read the comment before changing.
}
