return {
  "smoka7/hop.nvim",
  version = "*",
  opts = {
    keys = "etovxqpdygfblzhckisuran",
  },
  config = function()
    require("hop").setup()

    -- Register the top-level <leader>h group with which-key
    local wk = require("which-key")
    wk.add({
      { "<leader>h", group = "hop" }, -- group
      { "<leader>hw", "<cmd>HopWord<cr>", desc = "Hop Word" },
      { "<leader>hl", "<cmd>HopLine<cr>", desc = "Hop Line" },
      { "<leader>hn", "<cmd>HopNodes<cr>", desc = "Hop Nodes" },
    })
  end,
}
