vim.keymap.set('n', '<ESC>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<ECS><ESC>', '<C-\\><C-n>', {desc = 'Exit terminal mode' })

--Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

--Window commands
vim.keymap.set('n', '<C-h>', '<C-W><C-h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-W><C-l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-W><C-j', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-W><C-k', { desc = 'Move focus to the upper window' })

