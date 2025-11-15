{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: {
  # supporting tools
  home = {
    packages = with pkgs; [
      distrobox
      lazydocker
    ];

    # for easy login
    activation = {
      linkDockerSecrets = lib.hm.dag.entryAfter ["writeBoundary"] ''
        ln -sf $HOME/.secrets/docker/config.json $HOME/.docker/config.json
      '';
    };
  };
}
