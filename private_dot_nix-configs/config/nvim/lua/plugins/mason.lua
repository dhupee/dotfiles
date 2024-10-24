return {
  {
    "williamboman/mason.nvim",
    -- Disable Mason in favor of Nix packages
    enabled = false,
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- C++
        "clangd", -- lsp
        "cpplint", -- linter

        -- Docker
        "docker-compose-language-service", --lsp
        "dockerfile-language-server", -- lsp
        "hadolint", -- linter

        -- Go
        "gofumpt", -- formatter
        "goimports", -- formatter
        "gopls", -- lsp
        "golangci-lint", -- linter

        -- LaTeX
        "texlab", -- lsp
        "bibtex-tidy", -- formatter

        -- Lua
        "lua-language-server", -- lsp
        "stylua", -- formatter

        -- Markdown
        "markdownlint", -- linter, formatter
        "marksman", -- lsp

        -- -- Nix
        "nixd", -- lsp
        "alejandra", -- formatter

        -- HTML, JS, TS, CSS, JSON
        "prettier", -- formatter
        "json-lsp", -- lsp
        "biome", -- lsp, linter, formatter
        "typescript-language-server", -- lsp
        "vetur-vls", -- lsp
        "tailwindcss-language-server", -- lsp

        -- Python
        "ruff", -- linter and formatter
        "ruff-lsp", -- lsp

        -- Shell Script
        "bash-language-server", -- lsp
        "shellcheck", -- linter
        "beautysh", -- formatter

        -- YAML
        "yaml-language-server",
      })
    end,
  },
}
