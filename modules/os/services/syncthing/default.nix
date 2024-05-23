{ lib, config, username, ... }: {
  options = {
    module.service.syncthing.enable =
      lib.mkEnableOption "enables syncthing";
  };

  config = lib.mkIf config.module.service.syncthing.enable {
    services = {
      syncthing = {
        enable = true;
        user = "${username}";
        dataDir = "/home/${username}/Share"; # Default folder for new synced folders
        configDir = "/home/${username}/.config/syncthing"; # Folder for Syncthing's settings and keys
      };
    };
    networking.firewall.allowedTCPPorts = [ 22000 ];
    networking.firewall.allowedUDPPorts = [ 22000 21027 ];
  };
}
