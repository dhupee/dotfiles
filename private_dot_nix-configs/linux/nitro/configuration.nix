{
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    # Hardware
    ../../machines/nitro/hardware-configuration.nix

    # Tooling
    ../../modules/systems/docker.nix
    ../../modules/systems/cloudlare-warp.nix

    # Fonts
    ../../modules/systems/fonts.nix

    # User Configuration
    ../../users/dhupee.nix

    # Theming
    ../../theming/gnome/nitro/system.nix

    # Input Methods
    ../../modules/systems/input-methods.nix
  ];

  # Don't change this unless you know what you're doing!
  system.stateVersion = "24.05";

  # Enable experimental features.
  nix.settings.experimental-features = ["nix-command" "flakes"];

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
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "id_ID.UTF-8";
    LC_IDENTIFICATION = "id_ID.UTF-8";
    LC_MEASUREMENT = "id_ID.UTF-8";
    LC_MONETARY = "id_ID.UTF-8";
    LC_NAME = "id_ID.UTF-8";
    LC_NUMERIC = "id_ID.UTF-8";
    LC_PAPER = "id_ID.UTF-8";
    LC_TELEPHONE = "id_ID.UTF-8";
    LC_TIME = "id_ID.UTF-8";
  };

  #
  # # Enable the KDE Plasma Desktop Environment.
  # services.xserver.enable = true;
  # # services.xserver.displayManager.sddm.enable = true; # this one uses x11
  # services.displayManager.sddm.wayland.enable = true; # this one uses wayland
  # services.desktopManager.plasma6.enable = true;

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

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };

  # Enable sound with pipewire.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # Nano is installed by default
  environment.systemPackages =
    # with pkgs; [
    (with pkgs; [
      # vim
      bind
      curl
      gcc
      gnumake
      go-task
      home-manager
      htop
      nvtopPackages.full
      p7zip
      unrar
      unzip
      wget
      wl-clipboard
      # ];
    ])
    ++ (with pkgs-unstable; [
      codeium
    ]);

  # List services that you want to enable:
  services.openssh.enable = true;

  # Make sure udev is installed for platformio
  services.udev.packages = with pkgs; [platformio-core.udev];

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
