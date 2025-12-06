return {
  {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'jay-babu/mason-null-ls.nvim',
    },
    config = function()
      local null_ls = require 'null-ls'

      -- Set up Prettier
      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.prettier,
        },
        on_attach = function(client, bufnr)
          if client.supports_method 'textDocument/formatting' then
            local augroup = vim.api.nvim_create_augroup('LspFormatting', { clear = true })

            vim.api.nvim_create_autocmd('BufWritePre', {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format {
                  bufnr = bufnr,
                  filter = function(c)
                    return c.name == 'null-ls'
                  end,
                }
              end,
            })
          end
        end,
      }
    end,
  },
}
