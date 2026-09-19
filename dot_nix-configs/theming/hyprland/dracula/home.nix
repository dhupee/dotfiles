{
  lib,
  pkgs,
  config,
  ...
}: let
  # true: live symlink for fast tweaks. false: builtins.readFile for reproducible builds.
  debug = true;

  # Path used when debug = true.
  liveHyprland = "${config.home.homeDirectory}/.config/hypr/hyprland.conf";
in {
  wayland.windowManager.hyprland = {
    enable = false;
  };

  home.file = {
    ".config/hypr" = {
      # source = ./hypr;
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/share/chezmoi/mutable-configs/hyprland/dracula/hypr";
      recursive = true;
    };
  };
}
