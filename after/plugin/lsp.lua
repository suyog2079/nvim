require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed={'lua_ls','dockerls','clangd','ts_ls','pyright','html','rust_analyzer','ltex','cmake','markdown_oxide'}
})

local lspconfig = require('lspconfig')
local capabilities=require('cmp_nvim_lsp').default_capabilities()

lspconfig.lua_ls.setup({settings = {
	Lua = {
		diagnostics = {
			globals = { 'vim' }
		}
	}}},{capabilities = capabilities,})

	lspconfig.clangd.setup({capabilities = capabilities,})
	lspconfig.dockerls.setup({capabilities = capabilities,})
	lspconfig.cmake.setup({capabilities = capabilities,})
	lspconfig.ltex.setup({capabilities = capabilities,})
	lspconfig.rust_analyzer.setup({capabilities = capabilities,})
	lspconfig.html.setup({capabilities = capabilities,})
	lspconfig.ts_ls.setup({capabilities = capabilities,})
	lspconfig.markdown_oxide.setup({capabilities = capabilities,})
	lspconfig.pyright.setup({capabilities = capabilities,})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '?', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
