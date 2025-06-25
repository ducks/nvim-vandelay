local config = require('vandelay.config')

local M = {}

function M.get_indent_string(bufnr)
  local sw = vim.api.nvim_buf_get_option(bufnr, 'shiftwidth')
  local use_spaces = vim.api.nvim_buf_get_option(bufnr, 'expandtab')

  if use_spaces then
    return string.rep(' ', sw)
  else
    return '\t'
  end
end

function M.format(bufnr, names, prefix, suffix)
  if config.options.alphabetize then
    table.sort(names)
  end

  local indent = M.get_indent_string(bufnr)
  local lines = { prefix }
  for _, name in ipairs(names) do
    table.insert(lines, indent .. name .. ',')
  end
  table.insert(lines, suffix)
  return table.concat(lines, '\n')
end

return M
