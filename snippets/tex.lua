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
		"start",
		fmt(
			[[
\documentclass[14pt]{{extarticle}}
\usepackage{{amssymb,amsthm,amsmath, color}}
\usepackage{{graphicx}}
\usepackage{{fullpage}}
\usepackage{{subfigure}}
\usepackage{{graphics}}
\usepackage{{float}}
\usepackage{{array}}
\usepackage{{stmaryrd}}
\usepackage{{enumitem}}
\usepackage{{mdframed}}
\usepackage{{multicol}}
\usepackage{{listings}}
\usepackage{{xcolor}}

\lstset{{
  tabsize=2,
  showstringspaces=false,
  commentstyle=\color{{grey}},
  keywordstyle=\color{{red}},
  stringstyle=\color{{green}},
  basicstyle=\ttfamily
}}

\newtheorem{{theorem}}{{Theorem}}[section]
\newtheorem{{lemma}}[theorem]{{Lemma}}
\newtheorem{{proposition}}[theorem]{{Proposition}}
\newtheorem{{claim}}[theorem]{{Claim}}
\newtheorem{{corollary}}[theorem]{{Corollary}}
\newtheorem{{definition}}[theorem]{{Definition}}
\newtheorem{{observation}}[theorem]{{Observation}}
\newtheorem{{fact}}[theorem]{{Fact}}
\newtheorem{{property}}{{Property}}
\newtheorem{{remark}}{{Remark}}[section]
\newtheorem{{notation}}{{Notation}}[section]
\newtheorem{{example}}{{Example}}[section]
\newtheorem{{algorithm}}{{Algorithm}}
\newtheorem{{conjecture}}{{Conjecture}}
\newtheorem{{question}}[conjecture]{{Question}}

\newcommand{{\Z}}{{\mathbb{{Z}}}}

\title{{{}}}
\author{{{}}}
\date{{\today}}

\newcolumntype{{C}}{{>{{$}}c<{{$}}}} % math-mode version of "l" column type

\begin{{document}}

\maketitle

{}

\end{{document}}
      ]],
			{
				i(1, "Title"),
				i(2, "Author Name"),
				i(3, "% Document starts here!"),
			}
		)
	),
	s(
		"ex",
		fmt(
			[[
\begin{{tcolorbox}}
  \textbf{{\textit{{{}}}}}

  \medskip

  {}

\end{{tcolorbox}}
      ]],
			{
				i(1, "Example name"),
				i(2, "Example"),
			}
		)
	),
	s(
		"cse2321proof",
		fmt(
			[[
\begin{{proof}}[{}]

  Statement to prove: {}

  {}

\end{{proof}}

      ]],
			{
				i(1, "Proof method"),
				i(2, "Statement in predicate logic"),
				i(3, "% Proof body"),
			}
		)
	),
	s(
		"ilim",
		fmt(
			[[
\lim_{{{} \rightarrow \infty}}]],
			{
				i(1, "x"),
			}
		)
	),
  s(
    "sum",
    fmt(
      [[
\sum_{{{}}}^{{{}}}]],
      {
        i(1, "i=0"),
        i(2, "n")
      }
    )
  )
}

return snippets
