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
    ../modules/home-manager/git.nix
    ../modules/home-manager/gh.nix
    ../modules/home-manager/ghostty.nix
    ../modules/home-manager/neovim.nix
    ../modules/home-manager/starship/desktop.nix
    ../modules/home-manager/yazi.nix
    ../modules/home-manager/tmux.nix
    ../modules/home-manager/zsh.nix

    # theming
    # ../theming/hyprland/dracula/home.nix
    # ../theming/gnome/nitro/home.nix
    ../theming/plasma/dracula/home.nix
  ];

  # Don't change this without reading the docs.
  home.stateVersion = "24.05";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Home Manager GC settings
  nix = {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    # gc = {
    #   automatic = true;
    #   dates = "weekly";
    #   options = "--delete-older-than 7d";
    # };
  };

  # Packages
  home.packages =
    (with pkgs; [
      # with pkgs; [
      bat
      btop
      dust
      fastfetch
      fd
      fzf
      # mpv
      tldr
      tree
      zoxide
    ])
    ++ (with pkgs-unstable; [
      chezmoi
      firefox-bin
      yt-dlp
    ]);

  # Config that needs to be symlinked
  # CAREFUL: it's read-only
  home.file = {
    ".config/fastfetch/config.jsonc" = {
      source = ../config/fastfetch/aayush/config.jsonc;
      force = true;
    };

    # Mutable Configs
    ".config/btop".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/share/chezmoi/mutable-configs/btop";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
