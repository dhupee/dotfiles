-- Refer to this documentation:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {},
        biome = {},
        clangd = {},
        docker_compose_language_service = {},
        dockerls = {},
        gopls = {
          settings = {
            gopls = {
              semanticTokens = true,
              analyses = {
                unusedparams = true,
              },
              staticcheck = true,
              hints = {
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                constantValues = false,
                functionTypeParameters = false,
                parameterNames = false,
                rangeVariableTypes = false,
              },
            },
          },
        },
        html = {},
        jsonls = {},
        lua_ls = {
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        marksman = {},
        nixd = {
          settings = {
            nixd = {
              nixpkgs = {
                -- expr = "import <nixpkgs> { }",
                expr = 'import (builtins.getFlake "/home/dhupee/.nix-configs").inputs.nixpkgs { }',
              },
              formatting = {
                command = { "alejandra" },
              },
              options = {
                nixos = {
                  expr = '(builtins.getFlake "/home/dhupee/.nix-configs").nixosConfigurations."nitro".options',
                },
                -- wsl = {
                --   expr = '(builtins.getFlake "/home/dhupee/.nix-configs").nixosConfigurations."wsl-work".options',
                -- },
                home_manager = {
                  expr = '(builtins.getFlake "/home/dhupee/.nix-configs").homeConfigurations."dhupee".options',
                },
                -- nix_on_droid = {
                --   expr = '(builtins.getFlake "/home/dhupee/.nix-configs").nixOnDroidConfigurations."default".options',
                -- },
                -- NOTE:: other than nixos and home-manager cause the LSP to be heavy as fuck, so dont
              },
            },
          },
        },
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                typeCheckingMode = "basic",
                diagnosticMode = "openFilesOnly",
              },
            },
          },
        },
        ruff = {},
        svelte = {},
        tailwindcss = {},
        terraformls = {},
        texlab = {},
        tflint = {},
        ts_ls = {},
        volar = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
      },
    },
  },
}
