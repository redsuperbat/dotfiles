local M = {}

local function file_path()
  local filepath = vim.api.nvim_buf_get_name(0)

  if not filepath:match("spec%.rb$") then
    vim.api.nvim_err_writeln("Invalid test file")
    return
  end

  return filepath
end

function M.run_test_under_cursor()
  local filepath = file_path()
  if filepath == nil then
    return
  end

  local row = vim.api.nvim_win_get_cursor(0)[1]

  require("max.utils.terminal").open({
    cmd = string.format("rspec %s:%d", filepath, row),
  })
end

--- @param filepath string
function M.run_test_at(filepath)
  require("max.utils.terminal").open({
    cmd = string.format("rspec %s", filepath),
  })
end

function M.run_current_buffer()
  local filepath = file_path()
  if filepath == nil then
    return
  end

  require("max.utils.terminal").open({
    cmd = string.format("rspec %s", filepath),
  })
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*_spec.rb" },
  callback = function()
    vim.keymap.set("n", "<leader>tt", M.run_test_under_cursor, { desc = "Run rspec test on cursor" })
    vim.keymap.set("n", "<leader>tf", M.run_current_buffer, { desc = "Run rspec test on current buffer" })
  end,
})

return M
