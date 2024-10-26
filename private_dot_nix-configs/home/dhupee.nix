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

    # Input Method
    ../modules/home-manager/input-methods.nix

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
  home.packages =
    # (with pkgs; [
    with pkgs; [
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
      prusa-slicer
      # podman
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
  # ])
  # ++ (with pkgs-unstable; [
  #   # codeium
  #   orca-slicer
  #   # super-slicer
  # ]);

  # Config that needs to be symlinked
  # CAREFUL: it's read-only
  home.file = {
    ".aliases".source = ../aliases;
    ".config/containers".source = ../config/containers;
    ".config/alacritty".source = ../config/alacritty;
    ".config/btop".source = ../config/btop;
    ".tmux.conf".source = ../config/tmux.conf;
  };

  # some config I have isn't read-only, so this thing is needed
  home.activation = {
    linkPrusaSlicerConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ln -sf $HOME/.local/share/chezmoi/mutable-configs/PrusaSlicer $HOME/.config/PrusaSlicer
    '';
  };

  # Session variables
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
