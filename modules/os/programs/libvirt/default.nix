{ lib, config, username, pkgs, ... }: {
  options = {
    module.program.libvirt.enable =
      lib.mkEnableOption "enables libvirt";
    module.program.libvirt.virt-manager.enable =
      lib.mkEnableOption "enables virt-manager";
    module.program.libvirt.ovmf.enable =
      lib.mkEnableOption "enables ovmf";
  };

  config = lib.mkIf config.module.program.libvirt.enable {
    users.users.${username} = {
      extraGroups = [ "libvirtd" ];
    };
    environment.etc."libvirt/qemu.conf".text =
      lib.mkIf config.module.program.libvirt.ovmf.enable ''
        # Adapted from /var/lib/libvirt/qemu.conf
        # Note that AAVMF and OVMF are for Aarch64 and x86 respectively
        nvram = [ "/run/libvirt/nix-ovmf/AAVMF_CODE.fd:/run/libvirt/nix-ovmf/AAVMF_VARS.fd", "/run/libvirt/nix-ovmf/OVMF_CODE.fd:/run/libvirt/nix-ovmf/OVMF_VARS.fd" ]
      '';
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        vhostUserPackages = [ pkgs.virtiofsd ]; # shared file system
        ovmf = {
          enable = config.module.program.libvirt.ovmf.enable;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd
          ];
        };
      };
    };
    programs.virt-manager.enable = config.module.program.libvirt.virt-manager.enable;
  };
}
