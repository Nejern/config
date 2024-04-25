{ pkgs, ... }: {
  # Networking
  networking.networkmanager.enable = true;

  # Time
  time.timeZone = "Europe/Moscow";

  # System Packages
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    curl
  ];

  system.stateVersion = "23.11"; # Don't touch this.
}
