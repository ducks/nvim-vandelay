local M = {}
local core = require('vandelay.core')
local config = require('vandelay.config')

function M.setup(opts)
  config.setup(opts or {})
end

function M.format_current_line()
  core.format_current_line()
end

return M
