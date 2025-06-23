{
  pkgs,
  pkgs-unstable,
  inputs,
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
      # Compilers
      clang

      # C++
      clang-tools
      cpplint

      # Docker
      docker-compose-language-service
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
      stylua

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
      biome
      svelte-language-server
      typescript-language-server
      tailwindcss-language-server
      vscode-langservers-extracted
      vue-language-server

      # Shellscript
      bash-language-server
      shellcheck
      shfmt

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

  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  home.activation = {
    linkLazyLock = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ln -sf $HOME/.local/share/chezmoi/mutable-configs/nvim/lazy-lock.json $HOME/.config/nvim/
      ln -sf $HOME/.local/share/chezmoi/mutable-configs/nvim/lazyvim.json $HOME/.config/nvim/
    '';
  };
}
