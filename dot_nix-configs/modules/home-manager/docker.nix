{
  pkgs,
  lib,
  ...
}: {
  home = {
    packages = with pkgs; [
      lazydocker
    ];
    activation = {
      linkDockerSecrets = lib.hm.dag.entryAfter ["writeBoundary"] ''
        ln -sf $HOME/.secrets/docker/config.json $HOME/.docker/config.json
      '';
    };
  };
}
