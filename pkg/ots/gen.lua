rule('cxx', '$cc -std=c++11 -MD -MF $out.d $cflags -x c++ -c -o $out $in', {
	depfile='$out.d',
	deps='gcc',
})

cflags{
	'-I $srcdir/include',
	'-isystem $builddir/pkg/zlib/include',
}

pkg.hdrs = copy('$outdir/include', '$srcdir/include', {
	'opentype-sanitiser.h',
	'ots-memory-stream.h',
})
pkg.hdrs.install = true

pkg.deps = {
	'pkg/zlib/headers',
}

local objs = {}
for src in iterpaths([=[src/(
	avar.cc
	cff.cc
	cff_charstring.cc
	cmap.cc
	cvar.cc
	cvt.cc
	fpgm.cc
	fvar.cc
	gasp.cc
	gdef.cc
	glyf.cc
	gpos.cc
	gsub.cc
	gvar.cc
	hdmx.cc
	head.cc
	hhea.cc
	hmtx.cc
	hvar.cc
	kern.cc
	layout.cc
	loca.cc
	ltsh.cc
	math.cc
	maxp.cc
	metrics.cc
	mvar.cc
	name.cc
	os2.cc
	ots.cc
	post.cc
	prep.cc
	stat.cc
	variations.cc
	vdmx.cc
	vhea.cc
	vmtx.cc
	vorg.cc
	vvar.cc
)]=]) do
	objs[#objs + 1] = compile('cxx', src)
end

ar('libots.a', objs)

fetch 'curl'
