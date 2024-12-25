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

keymap("n", "gl", "g_")
keymap("n", "gh", "^")
keymap("v", "gl", "g_")
keymap("v", "gh", "^")

keymap("n", "<A-j>", ":m .+1<CR>==") -- move line up(n)
keymap("n", "<A-k>", ":m .-2<CR>==") -- move line down(n)
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv") -- move line up(v)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv") -- move line down(v)

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
keymap("n", "<leader>gd", function()
  vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Next Diagnostic" })
keymap("n", "<leader>gD", function()
  vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, { desc = "Prev Diagnostic" })

keymap("n", "<leader>ft", function()
  require("max.utils.terminal").open()
end, { desc = "Floating terminal" })

-- lazygit
keymap("n", "<leader>gg", function()
  require("max.utils.terminal").open("lazygit", {
    border = "none",
    on_buf_create = function(buf)
      -- Do nothing with q in lazygit
      vim.keymap.set("t", "q", function() end, { buffer = buf, nowait = true })
    end,
  })
end, { desc = "Lazygit" })

-- quit
keymap("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

keymap("n", "<leader>xx", "<cmd>source %<CR>", { desc = "Source current buffer file" })
keymap("n", "<leader>x", ":.lua<CR>", { desc = "Execute current line" })
keymap("v", "<leader>x", ":lua<CR>", { desc = "Execute current visual selection" })

-- Terminal Mappings
keymap("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
keymap("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })
keymap("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
keymap("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
keymap("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
keymap("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
keymap("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })
