-- Refer to this documentation:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = {},
        clangd = {},
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
        nixd = {},
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
        terraformls = {},
        texlab = {},
        tflint = {},
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
