{pkgs, ...}: {
  programs.nh = {
    enable = true;
    package = pkgs.nh;
    flake = /home/dhupee/.nix-configs;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 3 --keep-since 3d";
    };
  };
}
