return {
  -- when use edgy, need finetune other ui plugins
  {
    -- use edgy's selection window
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = {
      defaults = {
        get_selection_window = function()
          require("edgy").goto_main()
          return 0
        end,
      },
    },
  },

  {
    --prevent neo-tree from opening files in edgy windows
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = function(_, opts)
      opts.open_files_do_not_replace_types = opts.open_files_do_not_replace_types
        or { "terminal", "Trouble", "qf", "Outline", "trouble" }
      table.insert(opts.open_files_do_not_replace_types, "edgy")
    end,
  },

  {
    -- Fix bufferline offsets when edgy is loaded
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function()
      local Offset = require("bufferline.offset")
      if not Offset.edgy then
        local get = function()
          if package.loaded.edgy then
            local layout = require("edgy.config").layout
            local ret = { left = "", left_size = 0, right = "", right_size = 0 }
            for _, pos in ipairs({ "left", "right" }) do
              local sb = layout[pos]
              if sb and #sb.wins > 0 then
                local title = " Sidebar" .. string.rep(" ", sb.bounds.width - 8)
                ret[pos] = "%#EdgyTitle#" .. title .. "%*" .. "%#WinSeparator#��%*"
                ret[pos .. "_size"] = sb.bounds.width
              end
            end
            ret.total_size = ret.left_size + ret.right_size
            if ret.total_size > 0 then
              return ret
            end
          end
          return Offset.get()
        end
        Offset.get = get
        Offset.edgy = true
      end
    end,
  },
}
