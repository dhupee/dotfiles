{
  config,
  pkgs,
  ...
}: {
  programs.helix = {
    enable = true;
    # extraPackages = [];
  };
}
