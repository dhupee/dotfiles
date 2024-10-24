{
  lib,
  config,
  pkgs,
  pkgs-unstable,
  ...
}: {
  imports = [
    ../modules/home-manager/zsh.nix
    ../modules/home-manager/starship.nix
    ../modules/home-manager/neovim.nix
    ../modules/home-manager/git.nix
    ../modules/home-manager/gh.nix

    # theming
    ../theming/gnome/nitro/home.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dhupee";
  home.homeDirectory = "/home/dhupee";

  # Don't change this without reading the docs.
  home.stateVersion = "24.05";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # nixpkgs-unstable.config.allowUnfree = true;

  # Packages
  home.packages = with pkgs; [
    alacritty
    bat
    betterdiscordctl
    btop
    chezmoi
    discord
    distrobox
    dust
    fastfetch
    fzf
    lazygit
    libreoffice
    ngrok
    platformio-core
    # podman
    prusa-slicer
    tectonic-unwrapped
    thefuck
    tldr
    tree
    tmux
    zoxide

    # gtk themes
    tokyonight-gtk-theme

    # cursors
    comixcursors
    graphite-cursors

    # Fonts
    # Refer to this: https://github.com/ryanoasis/nerd-fonts?tab=readme-ov-file#patched-fonts
    (pkgs.nerdfonts.override {fonts = ["FiraCode" "Hack"];})
    corefonts

    # Shell scripts
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];
  # ++ (with pkgs-unstable; [
  #   codeium
  # ]);

  # Config that needs to be symlinked
  home.file = {
    ".aliases".source = ../aliases;
    ".config/PrusaSlicer".source = ../config/PrusaSlicer;
    ".config/containers".source = ../config/containers;
    ".config/alacritty".source = ../config/alacritty;
    ".config/btop".source = ../config/btop;
    ".tmux.conf".source = ../config/tmux.conf;
  };

  # Session variables
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
