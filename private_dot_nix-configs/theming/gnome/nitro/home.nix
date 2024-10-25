{
  pkgs,
  pkgs-unstable,
  ...
}: {
  programs = {
    gnome-shell = {
      enable = true;
      extensions = [
        {package = pkgs.gnomeExtensions.forge;}
        {package = pkgs.gnomeExtensions.user-themes;}
        {package = pkgs-unstable.gnomeExtensions.open-bar;}
        {package = pkgs.gnomeExtensions.dash-to-dock;}
      ];
    };
  };
}
