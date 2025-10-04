-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- End keymaps
local map = vim.keymap

-- Visual mode
map.set("v", "K", ":m '<-2<CR>gv=gv")
map.set("v", "J", ":m '>+1<CR>gv=gv")

-- Window
map.set("n", "<C-h>", "<C-w>h")
map.set("n", "<C-j>", "<C-w>j")
map.set("n", "<C-k>", "<C-w>k")
map.set("n", "<C-l>", "<C-w>l")
map.set("n", "+", "<C-w>>", { desc = "" })
map.set("n", "_", "<C-w><", { desc = "" })
map.set("n", "<A-=>", "<C-w>+", { desc = "" })
map.set("n", "<A-->", "<C-w>-", { desc = "" })

-- Tab
map.set("n", "<c-n>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
map.set("n", "<c-p>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
map.set("n", "<c-c>", "<cmd>bdelete!<cr>", { desc = "Close Buffer" })
--   { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
--   { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
--   { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
--   { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
--   { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
--   { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
--   { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
--   { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
--   { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
--   { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },

-- Diagnostic keymaps
map.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
map.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })

-- Custom keymaps
vim.g.dotnet_build_project = function()
  -- local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
  local cmd = "dotnet build -c Debug " .. vim.fn.getcwd() .. "\\"
  if vim.fn.confirm("Continue to build dotnet project using cmd: " .. cmd, "&yes\n&no", 2) == 1 then
    local exeResult = os.execute(cmd)
    if exeResult == 0 then
      print("Build: ✔️ ")
    else
      local ioResult = io.popen(cmd)
      if ioResult ~= nil then
        local out_put = ioResult:read("*all")
        print(out_put)
      end
    end
    -- local f = os.execute(cmd)
    -- if f == 0 then
    --     print('Build: ✔️ ')
    -- else
    --     print('Build: ❌ (code: ' .. f .. ')')
    -- end
  else
    print("Build canceled")
  end
end

vim.api.nvim_set_keymap("n", "<F4>", ":lua vim.g.dotnet_build_project()<CR>", { noremap = true, silent = true })
