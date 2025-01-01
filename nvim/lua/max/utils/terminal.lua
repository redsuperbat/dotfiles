local M = {}

---@param border string
local function win_config(border)
  local editor_width = vim.o.columns
  local editor_height = vim.o.lines
  local width = math.floor(editor_width * 0.8)
  local height = math.floor(editor_height * 0.8)
  local col = math.floor((editor_width - width) / 2)
  local row = math.floor((editor_height - height) / 2)

  return {
    relative = "editor",
    style = "minimal",
    border = border,
    width = width,
    height = height,
    col = col,
    row = row,
  }
end

---@class FloatingTerminalOptions
---@field on_buf_create? fun(buf: integer): nil
---@field border? string
---@field cmd? string[]|string
---@param opts? FloatingTerminalOptions
function M.open(opts)
  local cmd = (opts and opts.cmd) or vim.o.shell
  local border = (opts and opts.border) or "rounded"

  local config = function()
    return win_config(border)
  end

  ---@param buf integer
  local open_win = function(buf)
    vim.api.nvim_create_autocmd("BufEnter", {
      buffer = buf,
      callback = function()
        vim.cmd.startinsert()
      end,
    })
    local win = vim.api.nvim_open_win(buf, true, config())
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1f1f28" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1f1f28" })
    return win
  end

  ---@param buf integer
  local function open_win_with_resize(buf)
    local win = open_win(buf)
    vim.api.nvim_create_autocmd("VimResized", {
      callback = function()
        if not vim.api.nvim_win_is_valid(win) then
          return
        end
        vim.api.nvim_win_set_config(win, config())
      end,
    })
  end

  local buf = vim.api.nvim_create_buf(false, true)
  open_win_with_resize(buf)

  vim.fn.termopen(cmd)

  vim.keymap.set("n", "q", "<cmd>q<CR>", { buffer = buf, nowait = true })

  if opts and opts.on_buf_create then
    opts.on_buf_create(buf)
  end

  vim.keymap.set({ "t", "n" }, "<c-h>", "<c-h>", { buffer = buf, nowait = true })
  vim.keymap.set({ "t", "n" }, "<c-j>", "<c-j>", { buffer = buf, nowait = true })
  vim.keymap.set({ "t", "n" }, "<c-k>", "<c-k>", { buffer = buf, nowait = true })
  vim.keymap.set({ "t", "n" }, "<c-l>", "<c-l>", { buffer = buf, nowait = true })

  vim.cmd("noh")
end

return M
