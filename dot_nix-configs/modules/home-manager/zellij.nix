{
  pkgs,
  config,
  ...
}: {
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };

  home.file = {
    ".config/zellij".source = ../../config/zellij;
  };
}
