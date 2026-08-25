{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings = {
      git_protocol = "https";
    };
  };

  home.file = {
    ".config/gh/hosts.yml".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.secrets/gh/hosts.yml";
  };
}
