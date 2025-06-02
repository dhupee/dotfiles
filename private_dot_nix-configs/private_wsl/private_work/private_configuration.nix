# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # users
    ../../users/dhupee.nix

    # fonts
    ../../modules/systems/fonts.nix

    # wsl specific
    ../../modules/systems/wsl/usbip-horus-technology.nix
  ];

  # Enable experimental features
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Set timezone
  time.timeZone = "Asia/Jakarta";

  # Allow unfree
  nixpkgs.config.allowUnfree = true;

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
    defaultUser = "dhupee";
    startMenuLaunchers = true;
    usbip = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    curl
    gcc
    gnumake
    home-manager
    p7zip
    unrar
    unzip
    wayland
    weston
    wget
    wl-clipboard
    xwayland
    xorg.xhost
  ];

  environment.sessionVariables = {
    WAYLAND_DISPLAY = "wayland-0";
    DISPLAY = ":0";
    XDG_RUNTIME_DIR = "/run/user/1000";
  };

  services.udev.packages = with pkgs; [platformio-core.udev];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
