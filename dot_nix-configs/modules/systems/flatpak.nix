{
  pkgs,
  nix-flatpak,
  ...
}: {
  services.flatpak = {
    enable = true;
    remotes = [
      # Flathub is the default already present by this flake.
      #   {
      #     name = "flathub-beta";
      #     location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
      #   }
    ];
    packages = [
      # {
      #   appId = "io.github.philippkosarev.bmi";
      #   origin = "flathub";
      # }
      # "page.codeberg.lo_vely.Nucleus"
      "io.github.philippkosarev.bmi"
    ];
    uninstallUnmanaged = true;
    update = {
      auto = {
        enable = false;
      };
    };
  };
}
