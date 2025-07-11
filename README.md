# nvim-vandelay

> "What does Art Vandelay import?"

A Neovim plugin to automatically expand multiline imports.

## Features

- Language-aware import expansion
- Always emits trailing commas
- Lua-native, zero dependencies
- Fully configurable
- Easy to extend for more languages

## Supported Languages

- JavaScript / TypeScript (`import {}` blocks)
- Rust (`use {}` blocks)

## Installation

### lazy.nvim
```
{
  'ducks/nvim-vandelay',
  config = function()
    require('vandelay').setup({
      alphabetize = true, -- alphabetize module imports
      threshold = 2, -- min items to multiline
    })
  end
}
```

## Usage

Use a keybinding:

```
vim.keymap.set('n', '<leader>mi', function()
  require('vandelay').format_current_line()
end, { noremap = true, silent = true })
```

## What's it do?

This plugin applies opinionated import formatting. If you have 2 or more
imports in a block, it will always expand to multiline.

Start with this:

`import { foo, bar, baz, qux } from './utils';`

And get this:

```
import {
  foo,
  bar,
  baz,
  qux
} from './utils';
```

Same for Rust:

`use std::{fs, io, path};`

becomes:

```
use std::{
  fs,
  io,
  path,
};
```

## Testing

`nvim --headless -c 'PlenaryBustedDirectory tests/ --minimal_init=tests/minimal_init.lua'`

## TODOs

- [] Add more languages
- [] Treesitter integration
- [] Configurable width & indentation

## License

MIT
