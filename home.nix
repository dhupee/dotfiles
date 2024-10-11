{ config, pkgs, ... }:

{
  imports = [
    ./modules/zsh.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dhupee";
  home.homeDirectory = "/home/dhupee";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    alacritty
    lazygit
    fastfetch
    gh
    helix

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    
    ".p10k.zsh".source = ./config/p10k.zsh;
    ".aliases".source = ./aliases;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/dhupee/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

    # programs.zsh = {
    #     enable = true;
    #     initExtra = ''
    #         source ~/.p10k.zsh
    #
    #         # Sourcing aliases
    #         if [ -d ~/.aliases/ ]; then
    #             # Loop through all .sh files in the aliases directory and source them
    #             for file in ~/.aliases/*.sh; do
    #                 if [ -f "$file" ]; then
    #                     source "$file"
    #                 fi
    #             done
    #         else
    #             echo "Aliases directory not found"
    #         fi
    #
    #
    #         source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    #
    #         '';
    #     # initExtra = "source ~/.p10k.zsh";
    #     oh-my-zsh = {
    #         enable = true;
    #         # theme = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k";
    #         theme = "robbyrussell";
    #         plugins = [
    #             "thefuck"
    #             "copypath"
    #             "docker"
    #             "podman"
    #             "qrcode"
    #             "nvm"
    #             "node"
    #             "npm"
    #             "pyenv"
    #             "python"
    #             "golang"
    #             "zoxide"
    #         ];
    #     };
    # };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
