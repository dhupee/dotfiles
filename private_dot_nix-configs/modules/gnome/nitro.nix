{pkgs, ...}: {
  programs = {
    gnome-shell = {
      enable = true;
      extensions = [
        {package = pkgs.gnomeExtensions.forge;}
        {package = pkgs.gnomeExtensions.user-themes;}
        {package = pkgs.gnomeExtensions.open-bar;}
      ];
    };
  };
}
