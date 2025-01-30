local M = {}

--- @param cmd string
local function lazygit_term(cmd)
  require("max.utils.terminal").open({
    cmd = cmd,
    border = "none",
    on_buf_create = function(buf)
      -- Close window if lazyvim exits
      vim.api.nvim_create_autocmd("TermClose", {
        buffer = buf,
        callback = function()
          vim.cmd("close")
        end,
      })
      -- Quit lazygit when hitting esc + esc
      vim.keymap.set("t", "<esc><esc>", "<cmd>q<CR>", { buffer = buf, nowait = true, desc = "Quit" })
    end,
  })
end

function M.open()
  lazygit_term("lazygit")
end

function M.reflog()
  local file = vim.trim(vim.api.nvim_buf_get_name(0))
  lazygit_term(string.format("lazygit -f %s", file))
end

vim.keymap.set("n", "<leader>gg", M.open, { desc = "Lazygit" })
vim.keymap.set("n", "<leader>gr", M.reflog, { desc = "Git buffer reflog" })

return M
