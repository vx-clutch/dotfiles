local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
	s(
		{ trig = "main" },
		fmta(
			[[
        int
        main(void)
        {
        <>
        return 0;
        }
        ]],
			{ i(1), i(2), i(3) }
		)
	),

	s(
		{ trig = "for" },
		fmta(
			[[
        for (int i = <>; i <>; i++) {
            <>
        }
        ]],
			{ i(1), i(2), i(3) }
		)
	),
}
