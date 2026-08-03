{pkgs, ...}: {
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu;
      vhostUserPackages = with pkgs; [
        virtiofsd
        virtio-win
      ];
      swtpm.enable = true;
    };
  };
  environment.systemPackages = with pkgs; [
    dnsmasq
  ];
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  # Use this when using NixOS as Guest
  # services.qemuGuest.enable = true;
  # services.spice-vdagentd.enable = true;  # enable copy and paste between host and guest
}
