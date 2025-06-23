{
  pkgs,
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

  home.activation = {
    linkGhSecrets = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ln -sf $HOME/.secrets/gh/hosts.yml $HOME/.config/gh/hosts.yml
    '';
  };
}
