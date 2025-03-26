{pkgs, ...}: {
  programs = {
    ghostty = {
      enable = true;
      enableZshIntegration = true;
      installBatSyntax = true;
      installVimSyntax = true;
      settings = {
        "theme" = "Dracula";
        "font-size" = 10;
        "font-family" = "Hack Nerd Font";
      };
    };
  };
}
