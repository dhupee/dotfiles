{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: {
  services.podman.enable = true;

  # supporting tools
  home = {
    packages =
      (with pkgs; [
        podman-compose
        podman-desktop
        lazydocker
      ])
      ++ (with pkgs-unstable; [
        distrobox
        distrobox-tui
      ]);

    # For Lazydocker to work with podman
    sessionVariables = {
      DOCKER_HOST = "unix://$XDG_RUNTIME_DIR/podman/podman.sock";
    };

    file.".config/distrobox/distrobox.conf".text = ''
      container_manager="podman"
      skip_workdir="1"
    '';
  };
}
