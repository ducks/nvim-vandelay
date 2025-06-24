local M = {}
local config = require('vandelay.config')

function M.format_line(line)
  local pattern = [[import%s*{%s*(.-)%s*}%s*from%s*(.*);]]
  local imports, from = line:match(pattern)
  if not imports or not from then return nil end

  local parts = {}
  for item in imports:gmatch('[^,]+') do
    table.insert(parts, vim.trim(item))
  end

  if #parts < config.options.threshold then return nil end

  local indent = string.rep(' ', config.options.indent)
  local formatted = 'import {\n'
  for _, item in ipairs(parts) do
    formatted = formatted .. indent .. item .. ',\n'
  end
  formatted = formatted .. '} from ' .. from .. ';'
  return formatted
end

return M
