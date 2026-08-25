{
  pkgs,
  pkgs-unstable,
  config,
  lib,
  ...
}: {
  home = {
    packages = with pkgs-unstable; [
      kicad
      # kicad-small
    ];

    file = {
      ".config/kicad".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/share/chezmoi/mutable-configs/kicad";
    };
  };
}
