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
    };
  };

  # Use this when using NixOS as Guest
  # services.qemuGuest.enable = true;
  # services.spice-vdagentd.enable = true;  # enable copy and paste between host and guest
}
