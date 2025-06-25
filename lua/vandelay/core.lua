local languages = {
  javascript = require('vandelay.languages.javascript'),
  typescript = require('vandelay.languages.javascript'),
  rust = require('vandelay.languages.rust'),
}

local M = {}

function M.format_current_line()
  local bufnr = vim.api.nvim_get_current_buf()
  local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
  local lang = languages[filetype]

  if not lang then
    vim.notify('Vandelay: unsupported filetype ' .. filetype, vim.log.levels.WARN)
    return
  end

  local row = vim.api.nvim_win_get_cursor(0)[1] - 1
  local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1]

  -- Ask the language formatter if this line should be reformatted
  local formatted = lang.format_line(bufnr, line)

  if formatted then
    vim.api.nvim_buf_set_lines(bufnr, row, row + 1, false, { formatted })
  end
end

return M

