{
  config,
  lib,
  pkgs,
  ...
}: {
  # Simply install just the packages
  environment.packages = with pkgs; [
    # User-facing stuff that you really really want to have
    # Make sure its CLI only
    # Check the modules to prevent duplicate installs
    bat
    busybox
    chezmoi
    curl
    dust
    fastfetch
    fzf
    gnugrep
    man
    nano
    nmap
    tectonic
    thefuck
    tldr
    tmate
    tree
    wget
    yazi
    yt-dlp
    zoxide
  ];

  # Home-manager specific configuration
  home-manager.config = {
    # Don't change this willy nilly
    home.stateVersion = "24.05";

    # Importing any modules from Home.nix goes through here
    imports = [
      ../modules/home-manager/zoxide/droid.nix
      ../modules/home-manager/bash.nix
      ../modules/home-manager/git.nix
      ../modules/home-manager/gh.nix
      ../modules/home-manager/micro.nix
      ../modules/home-manager/starship/droid.nix
    ];

    home.file = {
      # Symlink config files you want, example:
      # ".screenrc".source = dotfiles/screenrc;

      ".config/helix".source = ../config/helix;
      ".aliases".source = ../aliases;
      ".config/yazi".source = ../config/yazi;
      ".tmate.conf".source = ../config/tmate.conf;
    };
  };

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Android/Termux specific configuration
  android-integration = {
    # to make sure I have access to phone's storage system
    termux-open.enable = true;
    termux-reload-settings.enable = true;
    termux-setup-storage.enable = true;
  };

  user.shell = "${pkgs.bashInteractive}/bin/bash";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone
  time.timeZone = "Asia/Jakarta";
}
