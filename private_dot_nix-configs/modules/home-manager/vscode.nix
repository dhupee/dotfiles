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
          name = "jsoncrack-vscode";
          publisher = "AykutSarac";
          version = "2.0.3";
          sha256 = "0pa49xg63la6gz5q652h25i2mf7wlj90rch9mpprwnbj9rw4qrb2";
        }
      ];
    userSettings = {
      "workbench.colorTheme" = "Dracula";
      "files.autoSave" = "afterDelay";
      "git.autoFetch" = true;
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
    };
  };
}
