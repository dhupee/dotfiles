{
  pkgs,
  nix-flatpak,
  ...
}: {
  # https://docs.flatpak.org/en/latest/index.html
  # https://github.com/gmodena/nix-flatpak

  services.flatpak = {
    enable = true;
    remotes = [
      {
        name = "flathub";
        location = "https://dl.flathub.org/repo/flathub.flatpakrepo";
      }
      {
        name = "flathub-beta";
        location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      }
    ];

    packages = [
      # {
      #   appId = "com.github.tchx84.Flatseal";
      #   origin = "flathub";
      # }
      # {
      #   appId = "com.vscodium.codium";
      #   origin = "flathub";
      # }
      {
        appId = "com.usebottles.bottles";
        origin = "flathub";
      }
      {
        appId = "org.freecad.FreeCAD";
        origin = "flathub";
      }
      {
        appId = "com.github.k4zmu2a.spacecadetpinball";
        origin = "flathub";
      }
    ];
    # overrides = {
    #   "com.vscodium.codium" = {
    #     context = {
    #       devices = "all";
    #       filesystems = "host";
    #       sockets = "wayland;x11;network";
    #       shared = "network;ipc";
    #     };
    #   };
    # };
    uninstallUnmanaged = true;
    uninstallUnused = true;
    update = {
      auto = {
        enable = true;
        onCalendar = "weekly";
      };
      onActivation = false;
    };
  };

  # Required to install flatpak
  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [
          "gtk"
        ];
      };
    };
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      #      xdg-desktop-portal-kde
      #      xdg-desktop-portal-gtk
    ];
  };
}
