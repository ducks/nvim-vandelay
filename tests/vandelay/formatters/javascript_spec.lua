local javascript = require('vandelay.formatters.javascript')
local config = require('vandelay.config')

describe('javascript formatter', function()
  before_each(function()
    config.setup({ threshold = 2, indent = 2 })
  end)

  it('does not modify single imports', function()
    local input = "import { foo } from './utils';"
    local result = javascript.format_line(input)
    assert.is_nil(result)
  end)

  it('formats multi imports correctly', function()
    local input = "import { foo, bar, baz } from './utils';"
    local expected = [[import {
  foo,
  bar,
  baz,
} from './utils';]]

    local result = javascript.format_line(input)
    assert.are.same(expected, result:gsub(";", ";"))  -- normalize trailing semicolon
  end)
end)
