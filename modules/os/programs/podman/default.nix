{ pkgs, lib, config, ... }: {
  options = {
    module.program.podman.enable =
      lib.mkEnableOption "enables virtualbox";
  };

  config = lib.mkIf config.module.program.podman.enable {
    virtualisation = {
      containers.enable = true;
      containers.storage.settings = {
        storage = {
          driver = "overlay";
          runroot = "/run/containers/storage";
          graphroot = "/var/lib/containers/storage";
          rootless_storage_path = "/tmp/containers-$USER";
          options.overlay.mountopt = "nodev,metacopy=on";
        };
      };

      # run container as systemd example
      #oci-containers.containers = {
      #  container-name = {
      #    image = "container-image";
      #    autoStart = true;
      #    ports = [ "127.0.0.1:1234:1234" ];
      #  };
      #};
      oci-containers.backend = "podman";
      podman = {
        enable = true;
        # Create a `docker` alias for podman, to use it as a drop-in replacement
        dockerCompat = false;
        # Required for containers under podman-compose to be able to talk to each other.
        defaultNetwork.settings.dns_enabled = true;
      };
    };
    environment.systemPackages = with pkgs; [ podman-compose podman-tui dive buildah ];
    environment.extraInit = lib.mkIf config.virtualisation.podman.dockerCompat ''
      if [ -z "$DOCKER_HOST" -a -n "$XDG_RUNTIME_DIR" ]; then
        export DOCKER_HOST="unix://$XDG_RUNTIME_DIR/podman/podman.sock"
      fi
    '';
  };
}
