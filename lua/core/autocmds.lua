local opts = require("core.config").autocmd_opts
local paths = require("core.config").paths
local api = vim.api

-- auto save buffer with throttling and filetype filtering
if opts.auto_save then
  local last_save_time = 0
  local save_throttle_ms = 1000 -- 1 second throttle

  -- Filetypes to exclude from auto-save
  local excluded_filetypes = {
    "dashboard",
    "grug-far",
    "alpha",
    "startify",
    "neo-tree",
    "NvimTree",
    "help",
    "man",
    "qf",
    "lspinfo",
    "TelescopePrompt",
    "noice",
    "notify",
    "toggleterm",
    "terminal",
    "prompt",
    "scratch",
  }

  api.nvim_create_autocmd({ "FocusLost", "QuitPre", "VimSuspend", "BufDelete", "BufLeave", "BufWipeout" }, {
    pattern = { "*" },
    callback = function()
      local buftype = vim.bo.buftype
      local filetype = vim.bo.filetype
      local bufname = vim.api.nvim_buf_get_name(0)

      -- Skip non-file buffers and special buffers
      if buftype ~= "" or filetype == "" or bufname == "" then
        return
      end

      -- Skip excluded filetypes
      for _, excluded_ft in ipairs(excluded_filetypes) do
        if filetype == excluded_ft then
          return
        end
      end

      -- Skip if buffer is not modifiable or readonly
      if not vim.bo.modifiable or vim.bo.readonly then
        return
      end

      -- Skip if buffer is not modified
      if not vim.bo.modified then
        return
      end

      -- Throttle saving
      local now = vim.uv.now()
      if now - last_save_time < save_throttle_ms then
        return
      end
      last_save_time = now

      vim.notify("auto saved ✨✨✨")
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
      "grug-far",
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
      vim.opt_local.spellfile = paths.spell_config_directory .. "/en.utf-8.add"
      vim.opt_local.wrap = true
      vim.opt_local.spell = true
      vim.opt_local.spelllang = "en_us,cjk"
      vim.opt_local.spelloptions:append("camel")
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
