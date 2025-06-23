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
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
      marketplace
      newReleases
      historyInSidebar
    ];
    theme = spicePkgs.themes.dracula;
    # colorScheme = "macchiato";
  };
}
