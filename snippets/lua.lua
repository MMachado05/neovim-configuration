local ls = require("luasnip")
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets = {
	s(
		"cfunc",
		fmt(
			[[
    config = function()
      {}
    end
  ]],
			{
				i(1, "configuration"),
			}
		)
	),
  s(
    "boilersnip",
    fmt(
      [[
      local ls = require("luasnip")
      local s = ls.s --> snippet
      local i = ls.i --> insert node
      local t = ls.t --> text node

      local d = ls.dynamic_node
      local c = ls.choice_node
      local f = ls.function_node
      local sn = ls.snippet_node

      local fmt = require("luasnip.extras.fmt").fmt
      local rep = require("luasnip.extras").rep

      local snippets = {{
        {}
      }}

      return snippets
      ]],
      {
        i(1, "-- Snippets go here")
      }
    )
  )
}

return snippets
