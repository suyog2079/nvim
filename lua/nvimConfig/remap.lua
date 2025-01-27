vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>d", vim.cmd.Neogen)
vim.keymap.set("n", "<leader>nt", vim.cmd.NERDTreeToggle)
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set('n', '<leader>tbar', vim.cmd.TagbarToggle)
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>tt', vim.cmd.ToggleTerm)
vim.keymap.set('n', 'bn', vim.cmd.bn)
vim.keymap.set('n', 'bp', vim.cmd.bp)
vim.opt.mouse = ""

local api = require('Comment.api')

-- these are for comments
vim.keymap.set('n', '<C-_>', api.toggle.linewise.current)

local esc = vim.api.nvim_replace_termcodes(
	'<esc>', true, false, true
)

-- Toggle selection (linewise)
vim.keymap.set('v', '<C-_>', function()
	vim.api.nvim_feedkeys(esc, 'x', false)
	api.toggle.linewise(vim.fn.visualmode())
end)
