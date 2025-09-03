return {
  -- "hrsh7th/nvim-cmp",
  -- dependencies = {
  --   -- codeium
  --   {
  --     "Exafunction/codeium.nvim",
  --     cmd = "Codeium",
  --     build = ":Codeium Auth",
  --     opts = {},
  --   },
  -- },
  -- ---@param opts cmp.ConfigSchema
  -- opts = function(_, opts)
  --   table.insert(opts.sources, 1, {
  --     name = "codeium",
  --     group_index = 1,
  --     priority = 100,
  --   })
  -- end,
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("codeium").setup({})
  end,
}
