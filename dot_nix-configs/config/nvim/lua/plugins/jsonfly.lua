return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "Myzel394/jsonfly.nvim",
  },
  keys = {
    {
      "<leader>j",
      "<cmd>Telescope jsonfly<cr>",
      desc = "Open json(fly)",
      ft = { "json" },
      mode = "n",
    },
  },
}
