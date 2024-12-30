local opts = require("core.config").autocmdOpts
local api = vim.api

-- auto save buffer
if opts.auto_save then
  api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
    pattern = { "*" },
    callback = function()
      vim.cmd("silent! wall")
    end,
    nested = true,
  })
end

-- auto restore cursor position
if opts.auto_restore_cursor_position then
  api.nvim_create_autocmd("BufReadPost", {
    pattern = { "*" },
    callback = function()
      if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
        vim.fn.setpos(".", vim.fn.getpos("'\""))
        vim.cmd("silent! foldopen")
      end
    end,
  })
end

-- remove auto-comments
if opts.auto_remove_new_lines_comment then
  api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*" },
    callback = function()
      vim.opt.formatoptions = vim.opt.formatoptions - { "c", "r", "o" }
    end,
  })
end

-- Highlight on yank
if opts.auto_hl_on_yank then
  api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      vim.highlight.on_yank()
    end,
  })
end

-- resize splits if window got resized
if opts.auto_resize_window then
  vim.api.nvim_create_autocmd({ "VimResized" }, {
    callback = function()
      local current_tab = vim.fn.tabpagenr()
      vim.cmd("tabdo wincmd =")
      vim.cmd("tabnext " .. current_tab)
    end,
  })
end

-- close some filetypes with <q>
if opts.auto_set_quit_map then
  api.nvim_create_autocmd("TermOpen", {
    pattern = { "*" },
    callback = function()
      local bufnr = api.nvim_get_current_buf()
      api.nvim_buf_set_keymap(bufnr, "n", "q", "<cmd>BufferDelete<cr><c-w>l", {
        silent = true,
        noremap = true,
      })
    end,
  })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "zsh",
      "toggleterm",
      "better_term",
      "PlenaryTestPopup",
      "help",
      "lspinfo",
      "man",
      "notify",
      "qf",
      "spectre_panel",
      "startuptime",
      "tsplayground",
      "neotest-output",
      "checkhealth",
      "neotest-summary",
      "neotest-output-panel",
    },
    callback = function(event)
      vim.bo[event.buf].buflisted = false
      vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
    end,
  })
end

if opts.auto_spell_check_text then
  -- wrap and check for spell in text filetypes
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "gitcommit", "markdown" },
    callback = function()
      vim.opt_local.spellfile = options.spell_config_directory .. "/en.utf-8.add"
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
    end,
  })
end

if opts.auto_reload_changed_file then
  vim.api.nvim_create_autocmd({ "FocusGained", "CursorHold" }, {
    pattern = { "*" },
    callback = function()
      pcall(vim.cmd, "checktime")
    end,
  })
end
