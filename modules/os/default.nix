{ lib, ... }: {
  imports = [
    ./essentials
    ./services
    ./programs

    ./manager/display
    ./manager/desktop
  ];
}
