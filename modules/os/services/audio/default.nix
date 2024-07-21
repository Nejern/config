{ lib, config, ... }: {
  options = {
    module.service.audio.enable =
      lib.mkEnableOption "enables audio";
  };

  config = lib.mkIf config.module.service.audio.enable {
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      extraConfig.pipewire."92-low-latency" = {
        context.properties = {
          default.clock = {
            rate = 48000;
            quantum = 32;
            min-quantum = 32;
            max-quantum = 32;
          };
        };
      };
    };
  };
}
