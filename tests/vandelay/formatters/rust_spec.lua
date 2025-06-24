local rust = require('vandelay.formatters.rust')
local config = require('vandelay.config')

describe('rust formatter', function()
  before_each(function()
    config.setup({ threshold = 2, indent = 2 })
  end)

  it('does not modify single imports', function()
    local input = "use std::fs;"
    local result = rust.format_line(input)
    assert.is_nil(result)
  end)

  it('formats multi imports correctly', function()
    local input = "use std::{fs, io, path};"
    local expected = [[use std::{
  fs,
  io,
  path,
};]]

    local result = rust.format_line(input)
    assert.are.same(expected, result)
  end)
end)

