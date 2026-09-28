-- qcms (Mozilla/UXP color management, ICC profiles), compiled directly
-- from the shared UXP checkout (see pkg/acme-client for the pattern).
set('srcdir', '$basedir/pkg/uxp/src/gfx/qcms')
cflags{
	'-Wall',
	'-I $srcdir',
}

pkg.deps = {
	'pkg/uxp/fetch',
}

local objs = objects([[
	chain.c
	iccread.c
	matrix.c
	transform.c
	transform_util.c
	transform-sse2.c
]])
objs[#objs + 1] = compile('cc', 'transform-sse1.c', nil, {cflags='$cflags -msse'})
ar('libqcms.a', objs)

pkg.hdrs = copy('$outdir/include', '$srcdir', {
	'qcms.h',
	'qcmstypes.h',
})
pkg.hdrs.install = true

build('phony', table.keys(pkg.inputs.fetch), 'pkg/uxp/fetch')
