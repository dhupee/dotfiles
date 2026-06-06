{
  config,
  pkgs,
  ...
}: {
  # No bootloader needed for containers
  boot.isContainer = true;

  # System version
  system.stateVersion = "24.05";

  # Hostname
  networking.hostName = "oci-bare";

  # Disable systemd-resolved (the source of the assertion)
  services.resolved.enable = false;

  # Basic networking (dhcp)
  networking.useDHCP = false;
  networking.interfaces.eth0.useDHCP = true;

  # Minimal environment
  environment.systemPackages = with pkgs; [
    bashInteractive
    chezmoi
    coreutils
    curl
    git
    home-manager
    vim
  ];

  # SSH (optional)
  services.openssh.enable = true;

  # Nix
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
}
