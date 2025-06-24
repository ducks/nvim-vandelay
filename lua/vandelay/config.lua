local M = {}

M.defaults = {
  threshold = 2,
  indent = 2,
}

M.options = {}

function M.setup(user_opts)
  M.options = vim.tbl_deep_extend('force', M.defaults, user_opts or {})
end

return M

