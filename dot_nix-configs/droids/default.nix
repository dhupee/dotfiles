{
  config,
  lib,
  inputs,
  pkgs,
  pkgs-unstable,
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
    netcat
    rustscan
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
  # NOTE: LSP wont help you in this for now
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
      # ../modules/home-manager/neovim.nix
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
  home-manager.extraSpecialArgs = {
    inherit pkgs-unstable;
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

  # default shell
  user.shell = "${pkgs.bashInteractive}/bin/bash";

  # terminal config
  terminal = {
    font = "${pkgs.nerd-fonts.hack}/share/fonts/truetype/NerdFonts/Hack/HackNerdFont-Regular.ttf";

    # Dracula colorscheme
    colors = {
      background = "#282a36";
      foreground = "#f8f8f2";
      cursor = "#f8f8f2";

      color0 = "#000000"; # black
      color1 = "#ff5555"; # red
      color2 = "#50fa7b"; # green
      color3 = "#f1fa8c"; # yellow
      color4 = "#bd93f9"; # blue
      color5 = "#ff79c6"; # magenta
      color6 = "#8be9fd"; # cyan
      color7 = "#bbbbbb"; # white (light gray)

      color8 = "#44475a"; # bright black (dark gray)
      color9 = "#ff6e6e"; # bright red
      color10 = "#69ff94"; # bright green
      color11 = "#ffffa5"; # bright yellow
      color12 = "#d6acff"; # bright blue
      color13 = "#ff92df"; # bright magenta
      color14 = "#a4ffff"; # bright cyan
      color15 = "#ffffff"; # bright white
    };
  };

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone
  time.timeZone = "Asia/Jakarta";
}
