cflags{
	'-I $srcdir/include',
	'-I $srcdir/lib',
	'-isystem $builddir/pkg/libogg/include',
}

pkg.hdrs = {
	copy('$outdir/include/vorbis', '$srcdir/include/vorbis', paths([[
		codec.h vorbisenc.h vorbisfile.h
	]])),
	install=true,
}
pkg.deps = {
	'$gendir/headers',
	'pkg/libogg/headers',
}

lib('libvorbis.a', [=[
	lib/(
		analysis.c bitrate.c block.c codebook.c envelope.c
		floor0.c floor1.c info.c lookup.c lsp.c lpc.c
		mapping0.c mdct.c psy.c registry.c res0.c sharedbook.c
		smallft.c synthesis.c window.c vorbisenc.c
	)
]=])

fetch 'curl'
