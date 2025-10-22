{ pkgs, username, hostname, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Modules
  module = {
    program = {
      wireguard.enable = true;
      obs-studio.enable = true;
    };
    service = {
      udev.rules.enable = true;
      audio.enable = true;
      syncthing.enable = true;
    };
    manager = {
      display.gdm.enable = true;
      desktop.hyprland.enable = true;
    };
  };

  # nixpkgs-wayland
  nix.settings = {
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
    ];
    substituters = [
      "https://cache.nixos.org"
      "https://nixpkgs-wayland.cachix.org"
    ];
  };
  nixpkgs.overlays = [ inputs.nixpkgs-wayland.overlay ];

  # User
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "input" ];
    shell = pkgs.zsh;
  };

  # Shell
  programs.zsh.enable = true;

  # Networking
  services.resolved.enable = true;
  #boot.initrd.systemd.network.enable = true;
  networking.hostName = hostname;
  networking.networkmanager = {
    enable = true;
    enableStrongSwan = true;
  };

  # Bootloader
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      #enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
    systemd-boot.enable = true;
  };

  # tmp dir
  boot.tmp = {
    useTmpfs = true;
    cleanOnBoot = true;
  };

  # Swap
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 32 * 1024;
  }];

  # Set your time zone.
  time.timeZone = "Europe/Moscow";
  # Windows time support
  #time.hardwareClockInLocalTime = true;

  nixpkgs.config.allowUnfree = true;
  # System Packages
  environment.systemPackages = with pkgs; [
    home-manager
    git
    neovim
    wget
    curlFull
    nh
    gwe
  ];

  # System Variables
  environment.sessionVariables = {
    NH_FLAKE = "/home/${username}/nixos";
  };

  hardware.bluetooth.enable = true;

  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib

    glm
    assimp
    stb
    glfw

    # from https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/games/steam/fhsenv.nix#L72-L79
    xorg.libXcomposite
    xorg.libXtst
    xorg.libXrandr
    xorg.libXext
    xorg.libX11
    xorg.libXfixes
    libGL
    libva

    # from https://github.com/NixOS/nixpkgs/blob/nixos-23.05/pkgs/games/steam/fhsenv.nix#L124-L136
    fontconfig
    freetype
    xorg.libXt
    xorg.libXmu
    libogg
    libvorbis
    SDL
    SDL2_image
    glew110
    libdrm
    libidn
    tbb
    zlib

    egl-wayland
  ];

  # Fonts
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      font-awesome
      material-design-icons
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      #proggyfonts
    ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";
    WLR_RENDERER = "vulkan";
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland;xcb";
    CLUTTER_BACKEND = "wayland";
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  # Load nvidia driver for Xorg and Wayland
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    forceFullCompositionPipeline = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    #package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  services.cpupower-gui.enable = true;

  # Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  # Gamemode
  programs.gamemode = {
    enable = true;
  };
  security.polkit.enable = true;

  system.stateVersion = "25.05"; # Don't touch this.
}
