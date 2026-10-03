rule('cxx', '$cc -std=c++11 -MD -MF $out.d $cflags -x c++ -c -o $out $in', {
	depfile='$out.d',
	deps='gcc',
})

-- upstream ships hunvisapi.h with a HUNSPELL_STATIC branch (empty export
-- macros); no generated config header is needed
cflags{
	'-D HUNSPELL_STATIC',
}

pkg.hdrs = copy('$outdir/include', '$srcdir/src/hunspell', {
	'atypes.hxx',
	'hunspell.h',
	'hunspell.hxx',
	'hunvisapi.h',
	'w_char.hxx',
})
pkg.hdrs.install = true

local objs = {}
for src in iterpaths([=[src/hunspell/(
	affentry.cxx
	affixmgr.cxx
	csutil.cxx
	filemgr.cxx
	hashmgr.cxx
	hunspell.cxx
	hunzip.cxx
	phonet.cxx
	replist.cxx
	suggestmgr.cxx
)]=]) do
	objs[#objs + 1] = compile('cxx', src)
end

ar('libhunspell.a', objs)

fetch 'curl'
