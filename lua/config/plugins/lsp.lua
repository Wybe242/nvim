local path =vim.fn.expand("~/.local/share/nvim/lsp_servers")
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      require("lspconfig").lua_ls.setup {
	cmd = { path.."/lua-language-server/bin/lua-language-server"}
      } 
    end,
  },
}
