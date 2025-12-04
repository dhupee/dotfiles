{pkgs, ...}: {
  programs.pay-respects = {
    enable = true;
    package = pkgs.pay-respects;
    enableBashIntegration = true;
    enableZshIntegration = true;
    options = [
      "--alias"
      "f"
    ];
  };
}
