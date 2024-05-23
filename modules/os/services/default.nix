{ lib, ... }: {
  imports = [
    ./tlp
    ./audio
    ./syncthing
  ];

  module.service.audio.enable = lib.mkDefault false;
  module.service.tlp.enable = lib.mkDefault false;
  module.service.syncthing.enable = lib.mkDefault false;
}
