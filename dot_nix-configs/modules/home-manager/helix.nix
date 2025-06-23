{
  config,
  pkgs,
  ...
}: {
  programs.helix = {
    enable = true;
    # settings = {
    #   theme = "autumn_night_transparent";
    #   editor.cursor-shape = {
    #     normal = "block";
    #     insert = "bar";
    #     select = "underline";
    #   };
    # };
    # languages.language = [
    #   {
    #     name = "nix";
    #     auto-format = true;
    #     formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
    #   }
    # ];
    # themes = {
    #   autumn_night_transparent = {
    #     "inherits" = "autumn_night";
    #     "ui.background" = {};
    #   };
    # };
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

    xdg.configFile = {
      "helix" = {
        source = ../../config/helix;
        recursive = true;
      };
    };
  };
}
