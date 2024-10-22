return {
  "danymat/neogen",
  config = true,
  cmd = "Neogen",
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
