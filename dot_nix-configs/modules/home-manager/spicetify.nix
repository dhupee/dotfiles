{
  pkgs,
  lib,
  spicetify-nix,
  ...
}: let
  spicePkgs = spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
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
    theme = {
      name = "Dracula";

      # NOTE: Always points to the actual CSS files
      src =
        pkgs.fetchFromGitHub {
          owner = "dracula";
          repo = "spicetify";
          rev = "63b2e835d8079d840277defa53651f65deee7d0c";
          sha256 = "003124pfv83ih5s36hsgig2izk83bfhkqr72221i60y825ms967z";
        }
        + "/Dracula";

      # Default settings
      injectCss = true;
      injectThemeJs = true;
      replaceColors = true;
      homeConfig = true;
      overwriteAssets = false;
      additonalCss = "";
    };
    # theme = spicePkgs.themes.dracula;
    # colorScheme = "macchiato";
  };
}
