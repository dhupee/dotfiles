return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    -- -- Function to execute shell commands and capture output
    -- local function exec(cmd)
    --   local handle = io.popen(cmd)
    --   local result = handle:read("*a")
    --   handle:close()
    --   return result
    -- end
    --
    -- -- Find the latest version of Codeium in the /nix/store
    -- local find_cmd = "ls -d /nix/store/*-codeium-* | sort -V | tail -n 1"
    -- local latest_version_path = exec(find_cmd):gsub("%s+", "") -- Remove any trailing whitespace
    --
    -- Configure Codeium with the dynamically found `bin_path`
    require("codeium").setup({
      -- bin_path = latest_version_path .. "/bin/codeium_language_server", -- Assuming the binary is in the /bin directory
      bin_path = "/run/current-system/sw/bin/codeium_language_server",
    })
  end,
}
