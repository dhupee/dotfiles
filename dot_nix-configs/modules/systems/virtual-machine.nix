{
  pkgs,
  vm-curator,
  ...
}: {
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu;
        vhostUserPackages = with pkgs; [
          /*
          NOTE:
          Windows Guest need to download this tools:
          - virtio-win-guest-tools
          - winfsp
          then enable virtio from service.msc, then also start
          */
          virtiofsd
          virtio-win
        ];
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };
  environment.systemPackages = with pkgs; [
    dnsmasq
    vm-curator.packages.${system}.default
  ];
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  # Use this when using NixOS as Guest
  # services.qemuGuest.enable = true;
  # services.spice-vdagentd.enable = true;  # enable copy and paste between host and guest
}
