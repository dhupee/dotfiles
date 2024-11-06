{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    colorschemes.dracula.enable = true;
    opts = {
      number = true;
      relativenumber = true;
    };
  };
}
