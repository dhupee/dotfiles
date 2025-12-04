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
    overrides = {
      "com.vscodium.codium".Context = {
        filesystem = [
          # it's nix, keep it ro
          "~/.config/git/config:ro"

          # Expose NixOS and Home-Manager packages
          "/run/current-system/sw/bin:ro"
          "~/.nix-profile/bin:ro"
        ];
      };
    };
  };
}
