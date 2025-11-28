return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      highlight = {
        enable = true,
      },
      rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1000,
      },
      indent = {
        enable = true,
      },
      ensure_installed = {
        "arduino",
        "bash",
        "c",
        "cpp",
        "csv",
        "dockerfile",
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "hcl",
        "javascript",
        "json",
        "jsonc",
        "latex",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "nix",
        "python",
        "regex",
        "templ",
        "terraform",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
  },
  {
    vim.filetype.add({
      pattern = {
        -- Template
        [".+%.toml%.tmpl"] = "toml",
        [".+%.json%.tmpl"] = "json",
        [".+%.yaml%.tmpl"] = "yaml",
        [".+%.yml%.tmpl"] = "yaml",
        -- Chezmoi
        [".chezmoiignore"] = "gitignore",
        [".chezmoiignore.tmpl"] = "gitignore",
      },
    }),
  },
}
