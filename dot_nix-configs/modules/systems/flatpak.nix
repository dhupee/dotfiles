{
  pkgs,
  nix-flatpak,
  ...
}: {
  services.flatpak = {
    enable = true;

    # Uncomment the entire list, not just the list
    remotes = [
      # Flathub is the default already present by this flake.
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
      #   appId = "io.github.philippkosarev.bmi";
      #   origin = "flathub";
      # }
      # "page.codeberg.lo_vely.Nucleus"
      # "io.github.philippkosarev.bmi"
      # "so.libdb.dissent"
      {
        appId = "com.visualstudio.code";
        origin = "flathub";
      }
    ];
    uninstallUnmanaged = true;
    update = {
      auto = {
        enable = false;
      };
    };
  };
}
