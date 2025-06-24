local M = {}
local js = require('vandelay.formatters.javascript')
local rust = require('vandelay.formatters.rust')

local handlers = {
  javascript = js,
  typescript = js,
  rust = rust,
}

function M.get_handler()
  local ft = vim.bo.filetype
  return handlers[ft]
end

function M.format_current_line()
  local handler = M.get_handler()
  if not handler then return end

  local line = vim.api.nvim_get_current_line()
  local formatted = handler.format_line(line)
  if formatted then
    local linenr = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_lines(0, linenr-1, linenr, false, vim.split(formatted, '\n'))
  end
end

function M.format_buffer()
  local handler = M.get_handler()
  if not handler then return end

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local changed = false
  for idx, line in ipairs(lines) do
    local formatted = handler.format_line(line)
    if formatted then
      vim.api.nvim_buf_set_lines(0, idx-1, idx, false, vim.split(formatted, '\n'))
      changed = true
    end
  end
end

return M

