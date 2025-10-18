{
  pkgs,
  pkgs-unstable,
  ...
}: {
  programs = {
    tmux = {
      enable = true;
      # package = pkgs.tmux;
      package = pkgs-unstable.tmux;
      prefix = "C-s";
      clock24 = true;
      baseIndex = 1;
      mouse = true;
      newSession = true;
      sensibleOnTop = true;
      keyMode = "vi";
      customPaneNavigationAndResize = true;
      escapeTime = 0;
      terminal = "screen-256color";
      extraConfig = ''
        # Rebind the splits
        unbind %
        bind | split-window -h
        unbind '"'
        bind - split-window -v

        # enable yazi to passtrough preview
        set -g allow-passthrough on
        set -ga update-environment TERM
        set -ga update-environment TERM_PROGRAM
      '';
      # plugins = with pkgs; [
      plugins = with pkgs-unstable; [
        tmuxPlugins.cpu
        tmuxPlugins.resurrect
        tmuxPlugins.vim-tmux-navigator
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '5' # minutes
          '';
        }
        {
          plugin = tmuxPlugins.dracula;
          extraConfig = ''
            # Dracula plugins setting
            # available plugins: battery, cpu-usage, git, gpu-usage, ram-usage, tmux-ram-usage, network, network-bandwidth, network-ping, ssh-session, attached-clients, network-vpn, weather, time, mpc, spotify-tui, kubernetes-context, synchronize-panes
            set -g @dracula-plugins "cpu-usage ram-usage time"
            set -g @dracula-show-left-icon session
          '';
        }
      ];
    };
  };
}
