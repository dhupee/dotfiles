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
    # spotifyPackage = pkgs.spotify;
    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      catJamSynced
      shuffle # shuffle+ (special characters are sanitized out of extension names)
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
      marketplace
      newReleases
      historyInSidebar
      ncsVisualizer
      # {
      #   # The source of the customApp
      #   # make sure you're using the correct branch
      #   # It could also be a sub-directory of the repo
      #   src = pkgs.fetchFromGitHub {
      #     owner = "";
      #     repo = "";
      #     rev = "";
      #     hash = "";
      #   };
      #   # The actual file name of the customApp usually ends with .js
      #   name = "";
      # }
    ];
    theme = spicePkgs.themes.dracula;
    # colorScheme = "macchiato";
  };
}
