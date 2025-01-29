local keymap = vim.keymap.set

-- buffers
keymap("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
keymap("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
keymap("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
keymap("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
keymap("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
keymap("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- Clear search with <esc>
keymap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
keymap(
  "n",
  "<leader>ur",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- Go to end of line and go to start of line
keymap("n", "gl", "g_", { desc = "Go to end of line" })
keymap("v", "gl", "g_", { desc = "Go to end of line" })
keymap("n", "gh", "^", { desc = "Go to start of line" })
keymap("v", "gh", "^", { desc = "Go to start of line" })

-- move line up(n)
-- option + j
keymap("n", "√", ":m .+1<CR>==")
-- move line down(n)
-- option + k
keymap("n", "ª", ":m .-2<CR>==")
-- move selection up(v)
-- option + j
keymap("v", "√", ":m '>+1<CR>gv=gv")
-- move selection down(v)
-- option + k
keymap("v", "ª", ":m '<-2<CR>gv=gv")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
keymap("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
keymap("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
keymap("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
keymap("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
keymap("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ";", ";<c-g>u")

-- save file
keymap({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- new file
keymap("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- better movement
keymap("n", "K", "<C-u>")
keymap("n", "J", "<C-d>")

-- diagnostic
keymap("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
keymap("n", "<leader>k", vim.lsp.buf.hover, { desc = "Hover over" })
keymap("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

keymap("n", "<leader>lr", ":LspRestart<CR>", { desc = "Restart LSP" })
keymap("n", "<leader>li", "<cmd>LspInfo<cr>", { desc = "LSP Info" })
keymap("n", "<leader>gd", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next Diagnostic" })
keymap("n", "<leader>gD", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Prev Diagnostic" })

keymap("n", "<leader>ft", function()
  require("max.utils.terminal").open({
    on_buf_create = function(buf)
      vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode", buffer = buf, nowait = true })
    end,
  })
end, { desc = "Floating terminal" })

-- lazygit
keymap("n", "<leader>gg", function()
  require("max.utils.terminal").open({
    cmd = "lazygit",
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
end, { desc = "Lazygit" })

-- quit
keymap("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })
-- Execute lua utils
keymap("n", "<leader>xx", "<cmd>source %<CR>", { desc = "Source current buffer file" })
keymap("n", "<leader>x", ":.lua<CR>", { desc = "Execute current line" })
keymap("v", "<leader>x", ":lua<CR>", { desc = "Execute current visual selection" })
