{pkgs, ...}: {
  programs.localsend = {
    enable = true;
    package = pkgs.localsend;
    openFirewall = true;
  };
}
