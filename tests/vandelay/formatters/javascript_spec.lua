local formatter = require('vandelay.languages.javascript')
local config = require('vandelay.config')

describe('javascript formatter alphabetize option', function()

  it('formats with alphabetize = true', function()
    config.setup({ alphabetize = true })

    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true

    local bufnr = 0
    local line = "import { bar, foo, baz } from './utils';"
    local expected = [[import {
  bar,
  baz,
  foo,
} from './utils';]]

    local result = formatter.format_line(bufnr, line)
    assert.equals(expected, result)
  end)

  it('formats with alphabetize = false', function()
    config.setup({ alphabetize = false })

    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true

    local bufnr = 0
    local line = "import { bar, foo, baz } from './utils';"
    local expected = [[import {
  bar,
  foo,
  baz,
} from './utils';]]

    local result = formatter.format_line(bufnr, line)
    assert.equals(expected, result)
  end)

end)

describe('javascript formatter threshold handling', function()

  it('does not modify single imports', function()
    config.setup({ alphabetize = true, threshold = 2 })

    local bufnr = 0
    local line = "import { foo } from './utils';"
    local result = formatter.format_line(bufnr, line)

    -- Expect no formatting change, should return nil
    assert.is_nil(result)
  end)

end)
