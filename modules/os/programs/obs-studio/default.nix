{ lib, config, pkgs, ... }: {
  options = {
    module.program.obs-studio.enable =
      lib.mkEnableOption "enables obs-studio";
  };

  config = lib.mkIf config.module.program.obs-studio.enable {
    programs.obs-studio = {
      enable = true;
      enableVirtualCamera = true;
    };
    boot.extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    boot.kernelModules = [ "snd-seq" "snd-rawmidi" "v4l2loopback" ];
    boot.extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
  };
}
