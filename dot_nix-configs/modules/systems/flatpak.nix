{pkgs, ...}: {
  # Enable Flatpak
  services.flatpak.enable = true;

  # Add Flathub
  systemd.services.flatpak-repos = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # Builder, in case I need it
  # environment.systemPackages = [ pkgs.flatpak-builder ];
}
