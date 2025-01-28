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
      # C++
      clang-tools
      cpplint

      # Docker
      dockerfile-language-server-nodejs
      hadolint

      # Go
      golangci-lint
      gopls
      gofumpt
      gotools

      # LaTeX
      texlab
      bibtex-tidy

      # Lua
      lua-language-server

      # Markdown
      markdownlint-cli
      marksman

      # Nix
      alejandra
      nixd

      # Python
      black
      isort
      pyright
      ruff

      # Javascripts and it's cronies
      nodePackages.prettier

      # Shellscript
      nodePackages.bash-language-server
      shellcheck
      shfmt
      stylua

      # Yaml
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
