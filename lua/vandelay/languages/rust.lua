local formatter = require('vandelay.formatter')

local M = {}

function M.format_line(bufnr, line)
  local pattern = [[use%s+(.-)%s*{%s*(.-)%s*};]]
  local path, names = string.match(line, pattern)
  if not path or not names then
    return nil
  end

  local items = {}
  for name in string.gmatch(names, '([^,]+)') do
    table.insert(items, vim.trim(name))
  end

  if #items < 2 then
    return nil
  end

  local formatted = formatter.format(bufnr, items, 'use ' .. path .. '{', '};')
  return formatted
end

return M
