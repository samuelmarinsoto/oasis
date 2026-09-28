cflags{
	'-I $srcdir/include',
}

lib('libnestegg.a', {'src/nestegg.c'})

pkg.hdrs = copy('$outdir/include/nestegg', '$srcdir/include/nestegg', {'nestegg.h'})
pkg.hdrs.install = true

fetch 'curl'
