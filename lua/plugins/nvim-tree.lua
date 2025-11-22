return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("nvim-tree").setup()

    vim.keymap.set("n", "<leader>e", "")
    vim.keymap.set("n", "<leader>E", "")
    vim.keymap.set("n", "<leader>ee", ":NvimTreeOpen<CR>", { noremap = true, silent = true, desc = "Open Nvim-[t]ree" })
    vim.keymap.set(
      "n",
      "<leader>ef",
      ":NvimTreeFindFile<CR>",
      { noremap = true, silent = true, desc = "Find [f]ile in file tree" }
    )
  end,
}
