{ lib, config, ... }: {
  options = {
    module.service.audio.enable =
      lib.mkEnableOption "enables audio";
  };

  config = lib.mkIf config.module.service.audio.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      #jack.enable = false;
      wireplumber = {
        enable = true;
        #extraConfig.bluetoothEnhancements = {
        #  "monitor.bluez.properties" = {
        #    "bluez5.enable-sbc-xq" = true;
        #    "bluez5.enable-msbc" = true;
        #    "bluez5.enable-hw-volume" = true;
        #    "bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
        #  };
        #};
      };
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
    # Noice suppression
    programs.noisetorch.enable = true;
  };
}
