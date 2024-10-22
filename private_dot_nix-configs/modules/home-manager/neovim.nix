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
    # plugins = with pkgs-unstable; [
    #   vimPlugins.codeium-nvim
    # ];
    extraPackages = with pkgs-unstable; [
      alejandra
      black
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
    ];
  };

  xdg.configFile = {
    "nvim" = {
      source = ../../config/nvim;
      recursive = true;
    };
  };
}
