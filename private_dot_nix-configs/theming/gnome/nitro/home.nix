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
        {package = pkgs.gnomeExtensions.kimpanel;}
      ];
    };
  };

  home.packages = with pkgs; [
    # gtk themes
    tokyonight-gtk-theme

    # cursors
    comixcursors
    graphite-cursors
  ];
}
