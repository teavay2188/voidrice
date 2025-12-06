vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.number = true
vim.o.relativenumber = true

vim.schedule(function()
	vim.o.clipboard = 'unnamedplus'
end)

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'

vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true 
vim.o.splitbelow = true
vim.o.scrolloff = 10
vim.o.cursorline = true 
vim.o.confirm = true 

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight wennnn yanking (coping) text',
	group = vim.api.nvim_create_augroup('highlight-yank', {clear = true}),
	callback = function()
		vim.hl.on_yank()
	end,
})

