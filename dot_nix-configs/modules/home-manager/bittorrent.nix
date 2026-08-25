{
  pkgs,
  config,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    nyaa
    stig
    transgui
    transmission_4-gtk
  ];

  home.file = {
    ".config/nyaa".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/share/chezmoi/mutable-configs/nyaa";
  };
}
