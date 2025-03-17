{
  pkgs,
  lib,
  ...
}: {
  services = {
    kdeconnect = {
      enable = true;
    };
  };

  home.packages = with pkgs; [
    polonium
  ];

  programs.plasma = {
    enable = true;
  };
}
