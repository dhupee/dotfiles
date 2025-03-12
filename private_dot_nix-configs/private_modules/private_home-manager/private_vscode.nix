{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    extensions = with pkgs.vscode-extensions;
      [
        # tooling
        aaron-bond.better-comments
        golang.go
        charliermarsh.ruff
        editorconfig.editorconfig
        foxundermoon.shell-format
        hediet.vscode-drawio
        jnoortheen.nix-ide
        llvm-vs-code-extensions.vscode-clangd
        mads-hartmann.bash-ide-vscode
        ms-azuretools.vscode-docker
        ms-python.debugpy
        ms-python.python
        ms-toolsai.jupyter
        ms-toolsai.jupyter-keymap
        ms-toolsai.jupyter-renderers
        ms-toolsai.vscode-jupyter-cell-tags
        ms-toolsai.vscode-jupyter-slideshow
        oderwat.indent-rainbow
        vscodevim.vim
        yzhang.markdown-all-in-one

        # theming
        dracula-theme.theme-dracula
        # ];
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          # https://marketplace.visualstudio.com/items?itemName=AykutSarac.jsoncrack-vscode
          name = "jsoncrack-vscode";
          publisher = "AykutSarac";
          version = "2.0.3";
          sha256 = "0pa49xg63la6gz5q652h25i2mf7wlj90rch9mpprwnbj9rw4qrb2";
        }
        {
          # https://marketplace.visualstudio.com/items?itemName=Codeium.codeium
          name = "codeium";
          publisher = "Codeium";
          version = "1.31.17";
          sha256 = "1vak6nab44ppz392qv6dky7q1pzb065yppy806m7wi7nj6dlnasp";
        }
      ];
    userSettings = {
      "workbench.colorTheme" = "Dracula";
      "files.autoSave" = "afterDelay";
      "git.autofetch" = true;
      "editor" = {
        "lineNumbers" = "relative";
        "formatOnSave" = true;
        "quickSuggesions" = {
          "comments" = "on";
          "strings" = "on";
        };
      };
      "nix" = {
        "enableLanguageServer" = true;
        "serverPath" = "${pkgs.nixd}/bin/nixd";
      };
      "hediet.vscode-drawio.theme" = "dark";
      "clangd.path" = "${pkgs.clang-tools}/bin/clangd";
    };
  };
}
