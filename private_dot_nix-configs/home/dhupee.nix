{ lib, config, pkgs, ... }:

{
  imports = [
    ../modules/home-manager/zsh.nix
    ../modules/home-manager/starship.nix
    ../modules/home-manager/neovim.nix
    ../modules/home-manager/git.nix
    ../modules/home-manager/gh.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dhupee";
  home.homeDirectory = "/home/dhupee";

  # Don't change this without reading the docs.
  home.stateVersion = "24.05";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Packages
  home.packages = with pkgs; [
    alacritty
    bat
    chezmoi
    discord
    fastfetch
    lazygit
    podman
    thefuck
    tree
    tmux
    zoxide

    # Fonts
    # Refer to this: https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#patched-fonts
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" "Hack" ]; })

    # Shell scripts
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Config that needs to be symlinked
  home.file = {
    ".aliases".source = ../aliases;
    ".config/PrusaSlicer".source = ../config/PrusaSlicer;
    ".config/containers".source = ../config/containers;
    ".tmux.conf".source = ../config/tmux.conf;
    ".config/alacritty".source = ../config/alacritty;
  };

  # Session variables
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
