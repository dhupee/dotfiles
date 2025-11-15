{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: {
  # supporting tools
  home = {
    packages =
      (with pkgs; [
        lazydocker
      ])
      ++ (with pkgs-unstable; [
        distrobox-tui
      ]);

    # # For Lazydocker to work with podman
    # sessionVariables = {
    #   DOCKER_HOST = "unix:///run/podman/podman.sock";
    # };

    file.".config/distrobox/distrobox.conf".text = ''
      container_manager="podman"
      skip_workdir="1"
    '';
  };
}
