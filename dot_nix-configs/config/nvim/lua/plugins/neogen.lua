return {
  "danymat/neogen",
  cmd = "Neogen",
  opts = {
    -- for a full list of annotation_conventions, see supported-languages below,
    languages = {
      lua = {
        template = {
          annotation_convention = "emmylua",
        },
      },
      go = {
        template = {
          annotation_convention = "godoc",
        },
      },
    },
  },
  keys = {
    {
      "<leader>cg",
      function()
        -- run neogen command
        return vim.cmd.Neogen()
      end,
      desc = "Generate documentation",
    },
  },
  -- Uncomment next line if you want to follow only stable versions
  -- version = "*"
}
