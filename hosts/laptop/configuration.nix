{ inputs, config, pkgs, username, hostname, ... }: {
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
      audio.enable = true;
      tlp.enable = true;
    };
    manager = {
      display.gdm.enable = true;
      desktop.gnome.enable = true;
    };
  };

  # User
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "vboxusers" ];
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
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
    efi = {
      canTouchEfiVariables = true;
    };
  };
  boot.tmp.useTmpfs = true;
  boot.tmp.cleanOnBoot = true;
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

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
    curl
  ];

  # OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  programs.nix-ld.enable = true;
  # "minimum" amount of libraries needed for most games to run without steam-run
  programs.nix-ld.libraries = with pkgs; [
    # common requirement for several games
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
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  system.stateVersion = "23.11"; # Don't touch this.
}
