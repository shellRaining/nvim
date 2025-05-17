local nvim_config_path = vim.fn.stdpath("config")
local snippets_path = nvim_config_path .. "/snippets"

local luasnip = {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load({ paths = { snippets_path } })
    local ls = require("luasnip")

    vim.keymap.set({ "i", "s" }, "<Tab>", function()
      ls.jump(1)
    end, { silent = true })
    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
      ls.jump(-1)
    end, { silent = true })
  end,
}

local snippets = {
  "chrisgrieser/nvim-scissors",
  cmd = { "ScissorsAddNewSnippet", "ScissorsEditSnippet" },

  keys = {
    { "<leader>ps", "<cmd>ScissorsAddNewSnippet<cr>", desc = "Add new snippet", mode = { "n", "x" } },
    { "<leader>pe", "<cmd>ScissorsEditSnippet<cr>", desc = "Edit snippet", mode = { "n", "x" } },
  },
  opts = function()
    return {
      snippetDir = snippets_path,
    }
  end,
}

return {
  luasnip,
  snippets,
}
