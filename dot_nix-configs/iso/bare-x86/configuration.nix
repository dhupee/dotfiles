{
  pkgs,
  modulesPath,
  ...
}: {
  # Imports
  imports = [
    # Needed for iso creation
    # For more options:
    # https://github.com/NixOS/nixpkgs/tree/master/nixos/modules/installer
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  # Explicitly determine the machine architecture
  nixpkgs.hostPlatform = "x86_64-linux";

  # Enable experimental features by default
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # System packages
  environment.systemPackages = with pkgs; [
    htop
    vim
  ];
}
