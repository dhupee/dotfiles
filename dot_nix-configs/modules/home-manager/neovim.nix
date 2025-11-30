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
    # package = pkgs.neovim-unwrapped;
    defaultEditor = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    extraPackages = with pkgs-unstable; [
      # extraPackages = with pkgs; [

      # NOTE: The packages list here can be run in nvim's cmdline but never outside of that
      # dart-ls no need to be installed, already integrated with Flutter

      # Compilers and other tooling
      clang
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
  xdg.configFile = {
    "nvim" = {
      source = ../../config/nvim;
      recursive = true;
    };
  };

  # Just in case
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  # Lazy lock should be mutable for easy update, so symlink like this
  home.activation = {
    linkLazyLock = lib.hm.dag.entryAfter ["writeBoundary"] ''
      ln -sf $HOME/.local/share/chezmoi/mutable-configs/nvim/lazy-lock.json $HOME/.config/nvim/
      ln -sf $HOME/.local/share/chezmoi/mutable-configs/nvim/lazyvim.json $HOME/.config/nvim/
    '';
  };
}
