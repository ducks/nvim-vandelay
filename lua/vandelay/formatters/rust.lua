local M = {}
local config = require('vandelay.config')

function M.format_line(line)
  local pattern = [[use%s*(.-)::%s*{%s*(.-)%s*};]]
  local base, imports = line:match(pattern)
  if not base or not imports then return nil end

  local parts = {}
  for item in imports:gmatch('[^,]+') do
    table.insert(parts, vim.trim(item))
  end

  if #parts < config.options.threshold then return nil end

  local indent = string.rep(' ', config.options.indent)
  local formatted = 'use ' .. base .. '::{\n'
  for _, item in ipairs(parts) do
    formatted = formatted .. indent .. item .. ',\n'
  end
  formatted = formatted .. '};'
  return formatted
end

return M
