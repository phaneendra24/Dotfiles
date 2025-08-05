return {

  'echasnovski/mini.map',
  version = false,
  config = function()
    local map = require 'mini.map'

    map.setup {
      integrations = {
        map.gen_integration.builtin_search(),
        map.gen_integration.gitsigns(),
        map.gen_integration.diagnostic(),
      },
      symbols = {
        encode = map.gen_encode_symbols.dot '4x2', -- compact dots
      },
      window = {
        side = 'right', -- place on right like VS Code
        width = 10, -- can adjust based on preference
        winblend = 25, -- transparency (0–100)
        show_integration_count = false,
      },
    }

    -- Start the minimap automatically
    vim.api.nvim_create_autocmd('VimEnter', {
      callback = function()
        map.open()
      end,
    })
  end,
}
