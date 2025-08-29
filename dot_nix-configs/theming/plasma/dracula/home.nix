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

  imports = [./configs.nix]; # the one that generated from rc2nix

  # packages specific to plasma
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

  programs.plasma = {
    enable = true;
    workspace = {
      clickItemTo = "select";
      theme = "Dracula";
      lookAndFeel = "Dracula";
      iconTheme = "Zafiro-icons-Dark";
      wallpaper = /home/dhupee/Wallpapers/2022_ford_rally1_36.jpeg;
    };

    panels = [
      {
        alignment = "center";
        floating = true;
        height = 34;
        location = "top";
        opacity = "adaptive";
        widgets = [
          "org.kde.plasma.kickoff" # windows button of KDE
          "org.kde.plasma.pager" # virtual desktop stuff
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.showdesktop"
        ];
      }
      {
        alignment = "center";
        floating = true;
        height = 60;
        hiding = "dodgewindows";
        lengthMode = "fit";
        location = "bottom";
        opacity = "adaptive";
        widgets = [
          {
            iconTasks = {
              launchers = [
                "applications:firefox.desktop"
                "applications:codium.desktop" # VSCodium
                "applications:spotify.desktop"
                "applications:com.mitchellh.ghostty.desktop"
                "applications:systemsettings.desktop"
                "applications:org.kicad.kicad.desktop"
                "applications:startcenter.desktop"
                "applications:vesktop.desktop" # Vesktop
                "applications:OrcaSlicer.desktop"
                "applications:org.kde.dolphin.desktop"
              ];
            };
          }
        ];
      }
    ];
  };

  # some app still need gtk, for now uses breeze for now
  gtk = {
    enable = true;
    theme = {
      name = "Breeze"; # Change to match your KDE theme
      package = pkgs.kdePackages.breeze-gtk;
    };
    iconTheme = {
      name = "Breeze"; # Match with your KDE icon theme
      package = pkgs.kdePackages.breeze-icons;
    };
  };
}
