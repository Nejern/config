{ pkgs, username, hostname, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Modules
  module = {
    program = {
      virtualbox.enable = true;
      podman.enable = true;
    };
    service = {
      udev.rules.enable = true;
      audio.enable = true;
      tlp.enable = true;
      syncthing.enable = true;
    };
    manager = {
      display.gdm.enable = true;
      desktop.hyprland.enable = true;
    };
  };

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
  networking.hostName = hostname;
  networking.networkmanager = {
    enable = true;
    enableStrongSwan = true;
  };

  # Bootloader
  boot.loader = {
    #grub = {
    #  enable = true;
    #  device = "nodev";
    #  efiSupport = true;
    #  useOSProber = true;
    #};
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # tmp dir
  boot.tmp = {
    useTmpfs = false;
    cleanOnBoot = true;
  };

  # Swap
  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 16 * 1024;
  }];

  # Set your time zone.
  time.timeZone = "Europe/Moscow";
  # Windows time support
  time.hardwareClockInLocalTime = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    home-manager
    git
    neovim
    wget
    curlFull
    nh
  ];

  # System Variables
  environment.sessionVariables = {
    FLAKE = "/home/${username}/nixos";
  };

  hardware.bluetooth.enable = true;
  #systemd.user.services.mpris-proxy = {
  #  description = "Mpris proxy";
  #  after = [ "network.target" "sound.target" ];
  #  wantedBy = [ "default.target" ];
  #  serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  #};

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
      nerdfonts
    ];
  };

  specialisation = {
    gamemode.configuration = {
      system.nixos.tags = [ "gamemode" ];
      # Load nvidia driver for Xorg and Wayland
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        prime = {
          offload = {
            enable = true;
            enableOffloadCmd = true;
          };
          # Make sure to use the correct Bus ID values for your system!
          amdgpuBusId = "PCI:5:0:0";
          nvidiaBusId = "PCI:1:0:0";
        };
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

        # Optionally, you may need to select the appropriate driver version for your specific GPU.
        #package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
    };
  };

  # Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };
  # Gamemode
  programs.gamemode = {
    enable = true;
  };

  system.stateVersion = "23.11"; # Don't touch this.
}
