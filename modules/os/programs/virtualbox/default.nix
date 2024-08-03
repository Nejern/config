{ lib, config, username, ... }: {
  options = {
    module.program.virtualbox.enable =
      lib.mkEnableOption "enables virtualbox";
  };

  config = lib.mkIf config.module.program.virtualbox.enable {
    users.users.${username} = {
      extraGroups = [ "vboxusers" ];
    };
    virtualisation.virtualbox = {
      host.enable = true;
      #host.enableExtensionPack = true;
      #guest.enable = true;
      #guest.x11 = true;
    };
  };
}
