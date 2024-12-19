{
  pkgs,
  lib,
  spicetify-nix,
  ...
}: let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.system};
in {
  programs.spicetify = {
    enable = true;
    # spicetifyPackage = pkgs.spicetify-cli;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle # shuffle+ (special characters are sanitized out of extension names)
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "macchiato";
  };
}
