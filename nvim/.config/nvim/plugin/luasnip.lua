local ls = require 'luasnip'
local types = require 'luasnip.util.types'

ls.config.set_config {
  history = true,
  updateevents = 'TextChanged,TextChangedI',
}

vim.keymap.set({ 'i', 's' }, '<c-j>', function ()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<c-k>', function ()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

vim.keymap.set('i', '<c-l>', function ()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

-- 0 is the last for some reason
local s = ls.snippet
local i = ls.insert_node
local c = ls.choice_node
local t = ls.text_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require('luasnip.extras.fmt').fmt
-- local rep = require('luasnip.extras').rep

-- local same = function (index)
--   return f(function (arg)
--     return arg[1]
--   end, { index })
-- end

-- use c-l to switch between choices
ls.add_snippets('all', {
  s('task', { c(1, {t "TODO", t "DONE"}) } ),
  s('curtime', f(function () return os.date "%D - %I:%M %p" end))
})

ls.add_snippets('lua', {
  s('req', fmt("local {} = require('{}')", {
    f(function(import_name)
      local parts = vim.split(import_name[1][1], '.', true)
      return parts[#parts] or ""
    end, { 1 }),
    i(1),
  }))
})

ls.add_snippets('typescriptreact', {
  s('useState', fmt('const [{}, set{}] = useState({})', {
    i(1, 'value'),
    f(function (tab)
      local var_name = tab[1][1]
      local first_letter = string.upper(string.sub(var_name, 1, 1))
      local rest = string.sub(var_name, 2, -1)
      return first_letter .. rest
    end, { 1 }),
    i(0)
  }))
})
