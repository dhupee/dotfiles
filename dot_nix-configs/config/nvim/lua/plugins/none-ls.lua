return {
  "nvimtools/none-ls.nvim",

  opts = function()
    local nls = require("null-ls")
    local helpers = require("null-ls.helpers")

    local dockerfmt = {
      name = "dockerfmt",
      method = nls.methods.FORMATTING,
      filetypes = { "dockerfile" },
      generator = helpers.formatter_factory({
        command = "dockerfmt",
        -- dockerfmt handles standard input and outputs to standard output
        args = { "-" },
        to_stdin = true,
      }),
    }
    return {
      root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
      sources = {
        -- code actions
        -- formatters
        nls.builtins.formatting.alejandra,
        nls.builtins.formatting.black.with({
          extra_args = { "--line-length", "120" },
        }),
        dockerfmt,
        nls.builtins.diagnostics.golangci_lint,
        nls.builtins.formatting.goimports,
        nls.builtins.diagnostics.hadolint,
        nls.builtins.diagnostics.markdownlint.with({ extra_args = { "--disable", "MD013" } }),
        nls.builtins.formatting.markdownlint,
        nls.builtins.formatting.prettier.with({
          filetypes = {
            "css",
            "markdown",
            "yaml.docker-compose",
            "yaml.kubernetes",
            "yaml",
          },
        }),
        nls.builtins.formatting.shfmt,
        nls.builtins.formatting.stylua,
        nls.builtins.formatting.terraform_fmt,
        -- linters
      },
      -- on_attach = function(client, bufnr)
      --   -- Disable diagnostics for helm files
      --   if vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "helm" then
      --     vim.diagnostic.disable(bufnr)
      --   end
      -- end,
    }
  end,
}
