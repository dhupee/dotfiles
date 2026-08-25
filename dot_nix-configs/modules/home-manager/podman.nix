{
  pkgs,
  pkgs-unstable,
  config,
  lib,
  ...
}: {
  services.podman = {
    enable = true;
    package = pkgs.podman;
  };

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

    # for easy login
    file = {
      ".config/docker/config.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.secrets/docker/config.json";
    };

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
