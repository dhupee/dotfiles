{
  pkgs,
  nix-flatpak,
  ...
}: {
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
      #   appId = "io.github.philippkosarev.bmi";
      #   origin = "flathub";
      # }
      # "page.codeberg.lo_vely.Nucleus"
      # "so.libdb.dissent"
      {
        appId = "com.vscodium.codium";
        origin = "flathub";
      }
    ];
    uninstallUnmanaged = true;
    update = {
      auto = {
        enable = false;
      };
      onActivation = true;
    };
  };
}
