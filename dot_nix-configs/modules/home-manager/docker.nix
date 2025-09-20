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
      ])
      ++ (with pkgs-unstable; [
        distrobox-tui
      ]);

    sessionVariables = {
      # To specify a container manager use one of
      DBX_CONTAINER_MANAGER = "docker";
    };

    # for easy login
    activation = {
      linkDockerSecrets = lib.hm.dag.entryAfter ["writeBoundary"] ''
        ln -sf $HOME/.secrets/docker/config.json $HOME/.docker/config.json
      '';
    };
  };
}
