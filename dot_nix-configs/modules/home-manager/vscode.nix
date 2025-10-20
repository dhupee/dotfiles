{pkgs, ...}: {
  # NOTE: If you want to install and change the plugins at will, use Flatpak not Nix
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium-fhs;
    profiles."default" = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      userSettings = {
        "window.newWindowProfile" = "dhupee";
      };
    };
    profiles."dhupee" = {
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
          ms-python.pylint
          ms-toolsai.jupyter
          ms-toolsai.jupyter-keymap
          ms-toolsai.jupyter-renderers
          ms-toolsai.vscode-jupyter-cell-tags
          ms-toolsai.vscode-jupyter-slideshow
          ms-vscode.cpptools
          ms-vscode.powershell
          oderwat.indent-rainbow
          platformio.platformio-vscode-ide
          tomoki1207.pdf
          vscodevim.vim
          yzhang.markdown-all-in-one

          # theming
          dracula-theme.theme-dracula
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            # https://marketplace.visualstudio.com/items?itemName=Codeium.codeium
            name = "codeium";
            publisher = "Codeium";
            version = "1.49.2";
            sha256 = "fLDR0Gb8J9DkKTwFm0oMHB1GENKH/Cj2jMb1AsP0ZpQ=";
          }
          {
            # https://marketplace.visualstudio.com/items?itemName=pomdtr.excalidraw-editor
            name = "excalidraw-editor";
            publisher = "pomdtr";
            version = "3.9.0";
            sha256 = "DTmlHiMKnRUOEY8lsPe7JLASEAXmfqfUJdBkV0t08c0=";
          }
          {
            # https://marketplace.visualstudio.com/items?itemName=AykutSarac.jsoncrack-vscode
            name = "jsoncrack-vscode";
            publisher = "AykutSarac";
            version = "5.0.0";
            sha256 = "ctJdpLeZLTm+IsuPHw2pvSVoiiNG9Nzm/YVmaz7jQKQ=";
          }
          {
            # https://marketplace.visualstudio.com/items?itemName=Wokwi.wokwi-vscode
            name = "wokwi-vscode";
            publisher = "Wokwi";
            version = "2.8.0";
            sha256 = "JaIQoxrX5sMt5dkxMsPaSxeiQcGyPEGnOsdUMPDiGPw=";
          }
        ];
      userSettings = {
        "clangd.path" = "${pkgs.clang-tools}/bin/clangd";
        "editor" = {
          "lineNumbers" = "relative";
          "formatOnSave" = true;
          "quickSuggesions" = {
            "comments" = "on";
            "strings" = "on";
          };
        };
        "excalidraw.theme" = "dark";
        "files.autoSave" = "afterDelay";
        "git" = {
          "autofetch" = true;
          "confirmSync" = false;
        };
        "hediet.vscode-drawio.theme" = "dark";
        "nix" = {
          "enableLanguageServer" = true;
          "serverPath" = "${pkgs.nixd}/bin/nixd";
        };
        "workbench.colorTheme" = "Dracula Theme";
      };
    };
  };
}
