local formatter = require('vandelay.languages.rust')
local config = require('vandelay.config')

describe('rust formatter', function()

  it('formats multi imports with alphabetize = true', function()
    config.setup({ alphabetize = true })

    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true

    local bufnr = 0
    local line = "use std::{ io, fs, path };"
    local expected = [[use std::{
    fs,
    io,
    path,
};]]

    local result = formatter.format_line(bufnr, line)
    assert.equals(expected, result)
  end)

  it('formats multi imports with alphabetize = false', function()
    config.setup({ alphabetize = false })

    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true

    local bufnr = 0
    local line = "use std::{ io, fs, path };"
    local expected = [[use std::{
    io,
    fs,
    path,
};]]

    local result = formatter.format_line(bufnr, line)
    assert.equals(expected, result)
  end)

  it('does not modify single imports', function()
    config.setup({ alphabetize = true })

    local bufnr = 0
    local line = "use std::{ fs };"
    local result = formatter.format_line(bufnr, line)
    assert.is_nil(result)
  end)

end)
