local formatter = require('vandelay.formatter')

local M = {}

function M.format_line(bufnr, line)
  -- Regex pattern to match named imports
  local pattern = [[import%s*{%s*(.-)%s*}%s*from%s*(.*);]]
  local names, from = string.match(line, pattern)
  if not names or not from then
    return nil
  end

  -- Split names by comma, trim whitespace
  local items = {}
  for name in string.gmatch(names, '([^,]+)') do
    table.insert(items, vim.trim(name))
  end

  -- Only rewrite if threshold is met (you can still wire this into config if you want)
  if #items < 2 then
    return nil
  end

  local formatted = formatter.format(bufnr, items, 'import {', '} from ' .. from .. ';')
  return formatted
end

return M
