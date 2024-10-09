{
  config,
  pkgs,
  ...
}: {
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [
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
}
