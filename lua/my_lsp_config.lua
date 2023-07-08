
local capabilities = require('cmp_nvim_lsp').default_capabilities()
--capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

  vim.keymap.set("n","K", vim.lsp.buf.hover, {buffer=0})
  vim.keymap.set("n","gd", vim.lsp.buf.definition, {buffer=0})
  vim.keymap.set("n","gtd", vim.lsp.buf.type_definition, {buffer=0})
  vim.keymap.set("n","<leader>gi", vim.lsp.buf.implementation, {buffer=0})
  vim.keymap.set("n","<leader>dn", vim.diagnostic.goto_next, {buffer=0})
  vim.keymap.set("n","<leader>dp", vim.diagnostic.goto_prev, {buffer=0})
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'html', 'cssls', 'tsserver', 'emmet_ls', 'vimls', 'pyright', 'intelephense','clangd','lua_ls'}



for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

require('lspconfig')['emmet_ls'].setup{
    filetypes = {'javascript','html','javascriptreact','css','typescript'}
}

require('lspconfig')['tsserver'].setup{
    init_options = {
        preferences = {
            includeCompletionsWithSnippetText = true,
            includeCompletionsForImportStatements = true}
    },
    settings = {
        completions = {
            completeFunctionCalls = true
        }
    }
}
