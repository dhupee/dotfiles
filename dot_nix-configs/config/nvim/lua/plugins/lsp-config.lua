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
                expr = "import <nixpkgs> { }",
              },
              formatting = {
                command = { "nixfmt" },
              },
              options = {
                nixos = {
                  expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.k-on.options',
                },
                home_manager = {
                  expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."ruixi@k-on".options',
                },
                flakes = true,
                nixosModules = true,
                autoEvalInputs = true,
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
