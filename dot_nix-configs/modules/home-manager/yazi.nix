{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    enableZshIntegration = true;
    enableBashIntegration = true;
    extraPackages = with pkgs; [
      jq
      poppler
      fd
      ripgrep
      fzf
      zoxide
      imagemagick
      wl-clipboard
    ];
  };

  # Yazi config file
  home.file = {
    ".config/yazi".source = ../../config/yazi;
  };
}
