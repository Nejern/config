{ inputs, pkgs, username, hostname, ... }: {
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
  networking.networkmanager.enable = true;

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
  hardware.opengl.enable = true;

  system.stateVersion = "23.11"; # Don't touch this.
}
