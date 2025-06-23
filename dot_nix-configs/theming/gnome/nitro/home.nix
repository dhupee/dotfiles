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
        {package = pkgs.gnomeExtensions.caffeine;}
        {package = pkgs.gnomeExtensions.blur-my-shell;}
      ];
    };
  };

  home.packages = with pkgs; [
    # gtk themes
    tokyonight-gtk-theme

    # cursors
    comixcursors
    graphite-cursors

    # ricing utilities
    dconf2nix
  ];

  home.file.".themes/Dexy-Color-Dark-GTK" = {
    source =
      pkgs.fetchFromGitHub {
        owner = "L4ki";
        repo = "Dexy-Plasma-Themes";
        rev = "482f615e375f411150d2a4fd4d0b3f0878733169"; # Pulls the latest version
        sha256 = "1rbwby6llb3xva6ffj0q8fah2gxqdsqzxww2hfj2mih3s1432hg8";
      }
      + "/Dexy GTK Themes/Dexy-Color-Dark-GTK"; # Only grab the Dark GTK variant
  };
}
