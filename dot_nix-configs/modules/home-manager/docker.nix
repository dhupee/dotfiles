{
  pkgs,
  pkgs-unstable,
  config,
  lib,
  ...
}: {
  # supporting tools
  home = {
    packages = with pkgs; [
      distrobox
      lazydocker
    ];

    home.file = {
      ".config/docker".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.secrets/docker";
    };
  };
}
