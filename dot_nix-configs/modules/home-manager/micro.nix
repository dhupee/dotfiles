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
      "syntax" = true;
      "autoclose" = true;
      "relativenumber" = true;
      "clipboard" = "external";
      "saveundo" = true;
    };
  };
}
