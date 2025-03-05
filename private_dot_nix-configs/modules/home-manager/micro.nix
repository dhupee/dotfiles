{
  pkgs,
  lib,
  ...
}: {
  programs.micro = {
    enable = true;
    settings = {
      "autoindent" = true;
      "tabsize" = 4;
      "tabstospaces" = true;
      "softwrap" = true;
      "syntax" = "on";
      "autoclose" = true;
      "relativenumber" = true;
      "clipboard" = "external";
      "colorscheme" = "tokyonight";
    };
  };
}
