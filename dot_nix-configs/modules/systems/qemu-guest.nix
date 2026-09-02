{...}: {
  # Services related to qemu
  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true; # Clipboard
  };

  # Mount shared folder
  fileSystems."/mnt/shared" = {
    device = "myshare";
    fsType = "virtiofs";
  };
}
