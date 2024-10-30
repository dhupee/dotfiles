{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    enableZshIntergration = true;
  };
}
