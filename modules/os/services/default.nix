{ lib, ... }: {
  imports = [
    ./tlp
    ./audio
    ./syncthing
    ./udev
  ];
}
