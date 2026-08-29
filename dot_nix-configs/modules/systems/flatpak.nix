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
      {
        # Bottles
        appId = "com.usebottles.bottles";
        origin = "flathub";
      }
      {
        # Flatseal
        appId = "com.github.tchx84.Flatseal";
        origin = "flathub";
      }
      {
        # FreeCAD
        appId = "org.freecad.FreeCAD";
        origin = "flathub";
      }
      {
        # KiCad
        appId = "org.kicad.KiCad";
        origin = "flathub";
      }
      {
        # KiCad's 3D Library
        # appId = "org.kicad.KiCad.Library.Packages3D";
        appId = "runtime/org.kicad.KiCad.Library.Packages3D/x86_64/stable";
        origin = "flathub";
      }
      {
        # Space Cadet Pinball
        appId = "com.github.k4zmu2a.spacecadetpinball";
        origin = "flathub";
      }
      # {
      #   # VSCodium
      #   appId = "com.vscodium.codium";
      #   origin = "flathub";
      # }
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
