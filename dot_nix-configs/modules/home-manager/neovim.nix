{
  pkgs,
  pkgs-unstable,
  inputs,
  config,
  lib,
  ...
}: {
  programs.neovim = {
    enable = true;
    package = pkgs-unstable.neovim-unwrapped;
    # package = pkgs.neovim-unwrapped;
    defaultEditor = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    extraPackages = with pkgs-unstable; [
      # extraPackages = with pkgs; [

      # NOTE: The packages list here can be run in nvim's cmdline but never outside of that
      # dart-ls no need to be installed, already integrated with Flutter

      # Arduino
      arduino-language-server

      # Compilers and other outside tooling
      clang
      cmake
      fzf
      gnumake
      tree-sitter

      # C++
      clang-tools
      cpplint

      # Docker
      docker-compose-language-service
      docker-language-server
      hadolint

      # Go
      golangci-lint
      gopls
      gofumpt
      gotools
      templ

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
      nil
      nixd

      # Openscad
      openscad-lsp

      # Python
      black
      isort
      pyright
      ruff

      # Javascripts and it's cronies
      astro-language-server
      biome
      emmet-language-server
      svelte-language-server
      tailwindcss-language-server
      typescript-language-server
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

  # Add my configs to .config directory
  home.file = {
    ".config/nvim" = {
      source = ../../config/nvim;
      recursive = true;
    };
    ".config/nvim/lazy-lock.json" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/share/chezmoi/mutable-configs/nvim/lazy-lock.json";
    };
    ".config/nvim/lazyvim.json" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.local/share/chezmoi/mutable-configs/nvim/lazyvim.json";
    };
  };

  # Just in case
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
}
