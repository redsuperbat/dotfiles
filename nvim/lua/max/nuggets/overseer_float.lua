local M = {}

---@param task overseer.Task
function M.enter(task)
  require("overseer").run_action(task, "open float")
  vim.cmd("startinsert!")
  vim.keymap.set("t", "<esc><esc>", function()
    vim.cmd.close()
  end)
end

return M
