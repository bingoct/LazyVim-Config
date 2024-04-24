return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap, default Hover
      keys[#keys + 1] = { "K", false }
      -- add a keymap
      keys[#keys + 1] = { "gh", vim.lsp.buf.hover, desc = "lsp hover" }
    end,
  },
}
