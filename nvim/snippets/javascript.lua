-- local ls = require("luasnip")
-- local f = ls.function_node
-- local l = require("luasnip.extras").l
-- local t = require("luasnip.extras").t
-- local i = require("luasnip.extras").i
-- local postfix = require("luasnip.extras.postfix").postfix

---@diagnostic disable: unused-local
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet

return {
	postfix(".log", {
		f(function(_, parent)
			return "console.log(" .. parent.snippet.env.POSTFIX_MATCH .. ");"
		end, {}),
	}),
	-- 两种写法都行，上面的太长
	postfix(".warn", {
		l("console.warn(" .. l.POSTFIX_MATCH .. ");"),
	}),
	postfix(".error", {
		l("console.error(" .. l.POSTFIX_MATCH .. ");"),
	}),
	postfix(".var", {
		t("var "),
		i(1, { "Variable" }),
		l(" = " .. l.POSTFIX_MATCH .. ";"),
	}),
	postfix(".const", {
		t("const "),
		i(1, { "Variable" }),
		l(" = " .. l.POSTFIX_MATCH .. ";"),
	}),
	postfix(".let", {
		t("let "),
		i(1, { "Variable" }),
		l(" = " .. l.POSTFIX_MATCH .. ";"),
	}),
}
