{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = pkgs-unstable.neovim-unwrapped;
    defaultEditor = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;

    extraPackages = with pkgs-unstable; [
      alejandra
      black
      codeium
      golangci-lint
      gopls
      gotools
      hadolint
      isort
      lua-language-server
      markdownlint-cli
      nixd
      nodePackages.bash-language-server
      nodePackages.prettier
      pyright
      ruff
      shellcheck
      shfmt
      stylua
      yaml-language-server

      # # nvim plugins
      # vimPlugins.codeium-nvim
    ];
  };

  xdg.configFile = {
    "nvim" = {
      source = ../../config/nvim;
      recursive = true;
    };
  };
}
