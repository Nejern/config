{ pkgs, username, ... }: {
  # Networking
  networking.networkmanager.enable = true;

  # SSH
  services.openssh.enable = true;

  # Time
  time.timeZone = "Europe/Moscow";

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "input" ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICXr2TNODs919yUgtrHahXU6UerrRIWSjjRYf2quJlKW nejern@yandex.ru"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM6TJequsmn5Y9RtYwn0QuXm78Jof59msH29fBZ6dyKe oenikitin@zlp.ooo#PC"
    ];
  };

  programs.zsh.enable = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    curl
  ];

  system.stateVersion = "25.05";
}
