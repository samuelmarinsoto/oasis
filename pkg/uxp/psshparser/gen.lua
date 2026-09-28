-- psshparser has no separate upstream release: compile it straight from
-- the shared UXP checkout that pkg/uxp fetches (see the acme-client
-- pattern of borrowing pkg/openbsd's tree).
set('srcdir', '$basedir/pkg/uxp/src/media/psshparser')

rule('cxx', '$cc -std=c++17 -MD -MF $out.d $cflags -x c++ -c -o $out $in', {
	depfile='$out.d',
	deps='gcc',
})

cflags{
	'-D MOZ_NO_MOZALLOC=1',
	'-isystem $outdir/include',
}

pkg.deps = {
	'pkg/uxp/fetch',
	'$gendir/mfbt',
}

-- source list per media/psshparser/moz.build
ar('libpsshparser.a', {compile('cxx', 'PsshParser.cpp')})

-- no fetch of our own: alias the borrowed sources to the checkout owned
-- by pkg/uxp so compiles order after it (as fetch() would for owned src)
build('phony', '$srcdir/PsshParser.cpp', 'pkg/uxp/fetch')
build('phony', '$srcdir/PsshParser.h', 'pkg/uxp/fetch')

-- stage the mfbt include closure the sources use (mozilla/*.h layout)
local mfbtdir = '$basedir/pkg/uxp/src/mfbt'
local mfbt = {
	'Assertions.h',
	'Attributes.h',
	'Compiler.h',
	'DebugOnly.h',
	'EndianUtils.h',
	'Likely.h',
	'MacroArgs.h',
	'Move.h',
	'StaticAnalysisFunctions.h',
	'TypeTraits.h',
	'Types.h',
}
phony('mfbt', copy('$outdir/include/mozilla', mfbtdir, mfbt))

pkg.hdrs = copy('$outdir/include/psshparser', '$srcdir', {'PsshParser.h'})
pkg.hdrs.install = true
