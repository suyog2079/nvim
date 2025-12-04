require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = { 'lua_ls', 'clangd', 'ts_ls', 'pyright', 'rust_analyzer', 'ltex', 'neocmake', 'markdown_oxide' }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.lsp.config.lua_ls.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { 'vim' } }
		}
	}
}, { capabilities = capabilities, })
vim.lsp.config.clangd.setup({ capabilities = capabilities, })
-- vim.lsp.config.dockerls.setup({capabilities = capabilities,})
vim.lsp.config.neocmake.setup({ capabilities = capabilities, })
vim.lsp.config.ltex.setup({ capabilities = capabilities, })
vim.lsp.config.rust_analyzer.setup({ capabilities = capabilities, })
-- vim.lsp.config.html.setup({capabilities = capabilities,})
vim.lsp.config.ts_ls.setup({ capabilities = capabilities, })
vim.lsp.config.markdown_oxide.setup({ capabilities = capabilities, })
vim.lsp.config.pyright.setup({ capabilities = capabilities, })

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

-- ==========================
-- Diagnostics in top-right
-- ==========================
vim.o.updatetime = 300

local diag_win = nil
local diag_buf = nil

local function close_diag_win()
  if diag_win and vim.api.nvim_win_is_valid(diag_win) then
    vim.api.nvim_win_close(diag_win, true)
  end
  diag_win = nil
  diag_buf = nil
end

local function show_diagnostics_top_right()
  close_diag_win() -- close old one first

  local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
  if vim.tbl_isempty(diagnostics) then
    return
  end

  diag_buf = vim.api.nvim_create_buf(false, true)
  local lines = {}
  local highlights = {}
  local seen = {}

  for _, d in ipairs(diagnostics) do
    local key = d.severity .. d.message
    if not seen[key] then
      seen[key] = true

      local prefix = ({
        [vim.diagnostic.severity.ERROR] = "Error: ",
        [vim.diagnostic.severity.WARN]  = "Warning: ",
        [vim.diagnostic.severity.INFO]  = "Info: ",
        [vim.diagnostic.severity.HINT]  = "Hint: ",
      })[d.severity] or ""

      -- split multi-line messages safely
      local msg_lines = vim.split(d.message, "\n", { trimempty = true })

      for i, m in ipairs(msg_lines) do
        local text = (i == 1 and prefix or "    ") .. m
        local line_num = #lines
        table.insert(lines, text)

        table.insert(highlights, {
          group = ({
            [vim.diagnostic.severity.ERROR] = "DiagnosticError",
            [vim.diagnostic.severity.WARN]  = "DiagnosticWarn",
            [vim.diagnostic.severity.INFO]  = "DiagnosticInfo",
            [vim.diagnostic.severity.HINT]  = "DiagnosticHint",
          })[d.severity],
          line = line_num,
          col = 0,
          len = #text,
        })
      end
    end
  end

  vim.api.nvim_buf_set_lines(diag_buf, 0, -1, false, lines)

  for _, h in ipairs(highlights) do
    vim.api.nvim_buf_add_highlight(diag_buf, -1, h.group, h.line, h.col, h.len)
  end

  diag_win = vim.api.nvim_open_win(diag_buf, false, {
    relative = "editor",
    anchor = "NE",
    width = 60,
    height = #lines,
    row = 1,
    col = vim.o.columns - 1,
    style = "minimal",
    border = "rounded",
    focusable = false,
  })
end

-- Show diagnostics when hovering
vim.api.nvim_create_autocmd("CursorHold", {
  callback = show_diagnostics_top_right,
})

-- Close diagnostics when moving away
vim.api.nvim_create_autocmd({ "CursorMoved", "BufLeave", "InsertEnter" }, {
  callback = close_diag_win,
})

