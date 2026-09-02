{
  lib,
  config,
  inputs,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    # tooling
    # ../modules/home-manager/bittorrent.nix
    # ../modules/home-manager/docker.nix
    ../modules/home-manager/git.nix
    ../modules/home-manager/gh.nix
    ../modules/home-manager/ghostty.nix
    # ../modules/home-manager/kicad.nix
    ../modules/home-manager/neovim.nix
    ../modules/home-manager/opencode.nix
    ../modules/home-manager/podman.nix
    ../modules/home-manager/qemu-host.nix
    ../modules/home-manager/starship/desktop.nix
    ../modules/home-manager/vscode.nix
    ../modules/home-manager/yazi.nix
    ../modules/home-manager/tmux.nix
    ../modules/home-manager/zoxide/nitro.nix
    ../modules/home-manager/zsh.nix

    # documentation
    ../modules/home-manager/docs.nix

    # spotify & spicetify
    ../modules/home-manager/spicetify.nix

    # theming
    # ../theming/hyprland/dracula/home.nix
    # ../theming/gnome/nitro/home.nix
    ../theming/plasma/dracula/home.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dhupee";
  home.homeDirectory = "/home/dhupee";

  # Don't change this without reading the docs.
  home.stateVersion = "24.05";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Home Manager GC settings
  nix = {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Packages
  home.packages =
    (with pkgs; [
      # with pkgs; [
      anki-bin
      # arduino-cli
      bat
      bruno
      btop
      # google-chrome
      # dbeaver-bin
      dust
      emote
      fastfetch
      fd
      ffmpeg
      fzf
      go-task
      gparted
      inkscape
      libreoffice
      mpv
      ngrok
      # node-red
      obs-studio
      # openscad
      pdfarranger
      pdfmm
      platformio-core
      # pulseview
      qbittorrent
      rclone
      rclone-browser
      speedtest-cli
      tectonic-unwrapped
      tldr
      tree
      tty-share
      vlc
      zoom-us
      zoxide
    ])
    ++ (with pkgs-unstable; [
      chezmoi
      firefox-bin
      # logisim-evolution
      obsidian
      orca-slicer
      vesktop
      yt-dlp
    ]);

  # Config that needs to be symlinked
  # CAREFUL: it's read-only
  home.file = {
    # ".config/containers".source = ../config/containers;
    ".config/MangoHud".source = ../config/MangoHud;
    ".config/fastfetch/config.jsonc" = {
      source = ../config/fastfetch/aayush/config.jsonc;
      force = true;
    };

    # Mutable Configs
    ".config/ngrok".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.secrets/ngrok";
    ".config/rclone".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.secrets/rclone";
    ".config/btop".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/share/chezmoi/mutable-configs/btop";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
