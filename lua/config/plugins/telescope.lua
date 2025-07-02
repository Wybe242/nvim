return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            theme = "ivy"
          }
        },
        extensions = {
          fzf = {},
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
            mappings = {
              ["n"] = {
                vim.keymap.set("n", "<space>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>")
              },
            }
          }
        },
      }

      require('telescope').load_extension('fzf')
      require("telescope").load_extension("file_browser")

      vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files)
      vim.keymap.set("n", "<space>fh", require('telescope.builtin').help_tags)
      vim.keymap.set("n", "<space>en", function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath('config')
        }
      end)
    end
  },
  -- {
  --   "nvim-telescope/telescope-file-browser.nvim",
  --   config = function()
  --     vim.keymap.set("n", "<space>fb", ":Telescope file_browser<CR>")
  --   end
  -- }
}
