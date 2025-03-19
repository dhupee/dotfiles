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

  home.file.".local/share/plasma/desktoptheme/Dracula" = {
    source =
      pkgs.fetchFromGitHub {
        owner = "dracula";
        repo = "gtk";
        rev = "fc59294cf67110f6487f5fd06d3c845ffffdf1a9";
        sha256 = "1czc32h13r0qiby4x04q9d5f8dyw1y2rh8g2x3xg2qmaa9prhn44";
      }
      + "/kde/plasma/desktoptheme/Dracula"; # because the directory is quite deep, pick the exact subdirectory
  };

  home.file.".local/share/plasma/look-and-feel/Dracula" = {
    source =
      pkgs.fetchFromGitHub {
        owner = "dracula";
        repo = "gtk";
        rev = "fc59294cf67110f6487f5fd06d3c845ffffdf1a9";
        sha256 = "1czc32h13r0qiby4x04q9d5f8dyw1y2rh8g2x3xg2qmaa9prhn44";
      }
      + "/kde/plasma/look-and-feel/Plasma6/Dracula";
  };

  home.file.".local/share/icons/Zafiro-icons-Dark" = {
    source =
      pkgs.fetchFromGitHub {
        owner = "zayronxio";
        repo = "Zafiro-icons";
        rev = "5c7f38ca3b01194104481ffb803111e31851cf5d"; # Pulls the latest version
        sha256 = "18w5zx02px7x74p6gc66j6lp2mwfxry0apfvxmw499bv7sh5hhpg";
      }
      + "/Dark"; # Only grab the Dark variant
  };

  imports = [./configs.nix];
}
