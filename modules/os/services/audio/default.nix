{ lib, config, ... }: {
  options = {
    module.service.audio.enable =
      lib.mkEnableOption "enables audio";
  };

  config = lib.mkIf config.module.service.audio.enable {
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      #extraConfig.pipewire."92-low-latency" = {
      #  "context.properties" = {
      #    "default.clock.rate" = 44100;
      #    "default.clock.quantum" = 512;
      #    "default.clock.min-quantum" = 512;
      #    "default.clock.max-quantum" = 512;
      #  };
      #};
    };
  };
}
