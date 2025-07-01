local path = vim.fn.expand("~/.local/share/nvim/lsp_servers")

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
      local lspconfig = require("lspconfig")

      -- Setup lua_ls
      lspconfig.lua_ls.setup {
        cmd = { path .. "/lua-language-server/bin/lua-language-server" },
      }
      -- Setup vscode-html-languageservice
      lspconfig.html.setup {}
      -- Setup typescript/javascript 
      lspconfig.ts_ls.setup {}

      vim.api.nvim_create_autocmd('LspAttach', {
	  group = vim.api.nvim_create_augroup('my.lsp', {}),
	  callback = function(args)
	    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
	    if not client then return end

	    -- Auto-format ("lint") on save.
	    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
	    if not client:supports_method('textDocument/willSaveWaitUntil')
	      and client:supports_method('textDocument/formatting') then
	      vim.api.nvim_create_autocmd('BufWritePre', {
		group = vim.api.nvim_create_augroup('my.lsp', {clear=false}),
		buffer = args.buf,
		callback = function()
		  vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
		end,
	      })
	    end
	  end,
	})
    end,
  },
}
