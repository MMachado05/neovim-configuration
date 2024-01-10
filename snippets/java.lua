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
  -- Snippets go here
  s(
    "class",
  fmt([[
  /**
   * TODO: Change this snippet's docstring.
   */
  {}{}{} {{
    {}
  }}
  
  ]], {
    c(1, { t(""), t("public "), t("private ")}),
    c(2, { t(""), t("static ")}),
        i(3, "ClassName"),
        i(4, "// Class content")
    }))
}

return snippets
