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
        distrobox
        lazydocker
        podman-compose
        podman-desktop
      ])
      ++ (with pkgs-unstable; [
        distrobox-tui
      ]);

    # For Lazydocker to work with podman
    sessionVariables = {
      DOCKER_HOST = "unix:///run/podman/podman.sock";
    };

    file.".config/distrobox/distrobox.conf".text = ''
      container_manager="podman"
      skip_workdir="1"
    '';

    # # for easy login
    # activation = {
    #   linkDockerSecrets = lib.hm.dag.entryAfter ["writeBoundary"] ''
    #     ln -sf $HOME/.secrets/docker/config.json $HOME/.docker/config.json
    #   '';
    # };
  };
}
