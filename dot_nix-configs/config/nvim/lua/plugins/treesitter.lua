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
        "bash",
        "c",
        "cpp",
        "csv",
        "dockerfile",
        "go",
        "gomod",
        "hcl",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "make",
        "markdown",
        "markdown_inline",
        "nix",
        "python",
        "regex",
        "terraform",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
  },
  {
    vim.filetype.add({
      pattern = {
        [".+%.toml%.tmpl"] = "toml",
        [".+%.json%.tmpl"] = "json",
        [".+%.yaml%.tmpl"] = "yaml",
        [".+%.yml%.tmpl"] = "yaml",
        -- add more mappings here, e.g.:
        -- [".+%.lua%.tmpl"] = "lua",
        -- [".+%.py%.tmpl"]  = "python",
      },
    }),
  },
}
