local M = {}
local core = require('vandelay.core')
local config = require('vandelay.config')

function M.setup(opts)
  config.setup(opts or {})

  if config.options.auto then
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        core.format_buffer()
      end
    })
  end
end

function M.format_current_line()
  core.format_current_line()
end

return M
