{
  lib,
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    # tooling
    ../modules/home-manager/zsh.nix
    ../modules/home-manager/starship/desktop.nix
    ../modules/home-manager/neovim.nix
    ../modules/home-manager/git.nix
    ../modules/home-manager/gh.nix
    ../modules/home-manager/yazi.nix
  ];

  home.username = "dhupee";
  home.homeDirectory = "/home/dhupee";

  # Don't change this without reading the docs.
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;

  home.packages = with pkgs; [
    bat
    chezmoi
    dust
    fzf
    go-task
    thefuck
    tldr
    tree
    tmux
    zoxide
  ];

  home.file = {
    ".aliases".source = ../aliases;
    ".config/yazi".source = ../config/yazi;
    ".tmux.conf".source = ../config/tmux.conf;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
