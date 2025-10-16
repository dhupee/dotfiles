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
        # lazydocker
        podman-tui
        podman-compose
        podman-desktop
      ])
      ++ (with pkgs-unstable; [
        distrobox-tui
      ]);

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
