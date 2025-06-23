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
    ../modules/home-manager/zoxide/work.nix
    ../modules/home-manager/zsh.nix
    ../modules/home-manager/starship/desktop.nix
    ../modules/home-manager/neovim.nix
    ../modules/home-manager/git.nix
    ../modules/home-manager/gh.nix
    ../modules/home-manager/yazi.nix
    ../modules/home-manager/zellij.nix
  ];

  home.username = "dhupee";
  home.homeDirectory = "/home/dhupee";

  # Don't change this without reading the docs.
  home.stateVersion = "24.05";

  nixpkgs.config.allowUnfree = true;
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  home.packages = with pkgs; [
    bat
    chezmoi
    dust
    fzf
    go-task
    htop
    platformio-core
    tectonic
    thefuck
    tldr
    tree
    zoxide
  ];

  home.file = {
    ".aliases".source = ../aliases;
    ".config/yazi".source = ../config/yazi;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
