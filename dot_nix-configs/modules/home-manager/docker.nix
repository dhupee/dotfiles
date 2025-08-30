{
  pkgs,
  lib,
  ...
}: {
  # supporting tools
  home = {
    packages = with pkgs; [
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
