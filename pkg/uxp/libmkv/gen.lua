set('srcdir', '$basedir/pkg/uxp/src/media/libmkv')
cflags{
	'-isystem $basedir/pkg/uxp/src/media/libvpx/libvpx',
}

pkg.hdrs = {
	copy('$outdir/include/libmkv', '$srcdir', {
		'EbmlBufferWriter.h',
		'EbmlIDs.h',
		'EbmlWriter.h',
		'WebMElement.h',
	}),
	install=true,
}

pkg.deps = {
	'pkg/uxp/fetch',
}

lib('libmkv.a', [[
	EbmlBufferWriter.c
	EbmlWriter.c
	WebMElement.c
]])

build('phony', table.keys(pkg.inputs.fetch), 'pkg/uxp/fetch');
