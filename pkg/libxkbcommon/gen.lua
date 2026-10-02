cflags{
	'-I $dir',
	'-I $srcdir/include',
	'-I $srcdir/src',
	'-I $outdir/src/xkbcomp',
}

pkg.hdrs = copy('$outdir/include/xkbcommon', '$srcdir/include/xkbcommon', {
	'xkbcommon.h',
	'xkbcommon-compat.h',
	'xkbcommon-keysyms.h',
	'xkbcommon-names.h',
})

-- parser.c/parser.h are yacc-generated; the git tree does not ship them.
-- bison in yacc mode writes parser.tab.c/parser.tab.h; parser-priv.h
-- includes "parser.h", so expose it under the expected name.
build('yacc', {
	'$outdir/src/xkbcomp/parser.tab.c',
	'$outdir/src/xkbcomp/parser.tab.h',
}, '$srcdir/src/xkbcomp/parser.y', {
	yaccflags = '-d -b $outdir/src/xkbcomp/parser',
})
build('copy', '$outdir/src/xkbcomp/parser.h', '$outdir/src/xkbcomp/parser.tab.h')

-- the generated parser calls yylex/yyerror; the scanner/param glue in the
-- tree names them _xkbcommon_lex/_xkbcommon_error - rename the calls
build('sed', '$outdir/src/xkbcomp/parser.c', '$outdir/src/xkbcomp/parser.tab.c', {
	expr = {
		'-e', 's/yylex/_xkbcommon_lex/g',
		'-e', 's/yyerror/_xkbcommon_error/g',
	},
})

local objs = objects([[src/(
	compose/parser.c
	compose/paths.c
	compose/state.c
	compose/table.c
	xkbcomp/action.c
	xkbcomp/ast-build.c
	xkbcomp/compat.c
	xkbcomp/expr.c
	xkbcomp/include.c
	xkbcomp/keycodes.c
	xkbcomp/keymap.c
	xkbcomp/keymap-dump.c
	xkbcomp/keywords.c
	xkbcomp/rules.c
	xkbcomp/scanner.c
	xkbcomp/symbols.c
	xkbcomp/types.c
	xkbcomp/vmod.c
	xkbcomp/xkbcomp.c
	atom.c
	context.c
	context-priv.c
	keysym.c
	keysym-utf.c
	keymap.c
	keymap-priv.c
	state.c
	text.c
	utf8.c
	utils.c
)]], {'$outdir/src/xkbcomp/parser.h'})
objs[#objs + 1] = '$outdir/src/xkbcomp/parser.c.o'
build('cc', '$outdir/src/xkbcomp/parser.c.o',
	{'$outdir/src/xkbcomp/parser.c', '|', '$outdir/src/xkbcomp/parser.h'})
ar('libxkbcommon.a', objs)

fetch 'git'
