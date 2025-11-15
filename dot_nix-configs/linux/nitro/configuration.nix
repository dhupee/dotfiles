{
  config,
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    # Hardware
    ../../machines/nitro/hardware-configuration.nix
    ../../machines/nitro/drivers.nix
    ../../machines/nitro/nbfc.nix

    # Gaming
    ../../modules/systems/gaming.nix

    # Tooling
    # ../../modules/systems/android-dev.nix
    ../../modules/systems/cloudlare-warp.nix
    ../../modules/systems/docker.nix
    ../../modules/systems/flatpak.nix
    ../../modules/systems/podman.nix
    ../../modules/systems/virtual-machine.nix

    # Fonts
    ../../modules/systems/fonts.nix

    # User Configuration
    ../../users/dhupee.nix

    # Theming
    # ../../theming/hyprland/dracula/systems.nix
    # ../../theming/gnome/nitro/system.nix
    ../../theming/plasma/dracula/system.nix

    # Input Methods
    ../../modules/systems/input-methods.nix
  ];

  # Don't change this unless you know what you're doing!
  system.stateVersion = "24.05";

  # Enable experimental features.
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nitro"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    # extraLocaleSettings = {
    #   LC_CTYPE = "en_US.UTF-8";
    #   LC_ADDRESS = "id_ID.UTF-8";
    #   LC_IDENTIFICATION = "id_ID.UTF-8";
    #   LC_MEASUREMENT = "id_ID.UTF-8";
    #   LC_MONETARY = "id_ID.UTF-8";
    #   LC_NAME = "id_ID.UTF-8";
    #   LC_NUMERIC = "id_ID.UTF-8";
    #   LC_PAPER = "id_ID.UTF-8";
    #   LC_TELEPHONE = "id_ID.UTF-8";
    #   LC_TIME = "id_ID.UTF-8";
    # };
    extraLocaleSettings = {
      LC_ALL = "en_US.UTF-8";
    };
  };

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      gutenprint
      canon-cups-ufr2
      cups-filters
      epson-escpr
    ];
  };

  # Enable Avahi, not sure what it does it's been there
  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
  };

  # System packages, Nano is installed by default
  # NOTE: Avoid using unstable-packages
  environment.systemPackages = with pkgs; [
    # vim
    bind
    curl
    gcc
    home-manager
    nixpkgs-manual
    nix-prefetch-git
    nvtopPackages.full
    p7zip
    unrar
    unzip
    wget
    wl-clipboard
  ];

  # List services that you want to enable:
  services.openssh.enable = true;

  # Make sure udev is installed for platformio
  services.udev.packages = with pkgs; [
    platformio-core.udev
  ];

  # Dynamic Linking
  programs.nix-ld = {
    enable = true;
    libraries = [];
  };

  # File Systems, adding secondary SSD
  fileSystems."/mnt/secondDrive" = {
    device = "/dev/disk/by-uuid/1b339a8a-3c99-4c16-9e93-976364b6698e";
    fsType = "ext4";
    options = [
      # If you don't have this options attribute, it'll default to "defaults"
      # mount options for fstab, check https://man.archlinux.org/man/mount.8#Generic_Mount_Options
      "users" # Allows any user to mount and unmount
      "nofail" # Prevent system from failing if this drive doesn't mount
    ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
