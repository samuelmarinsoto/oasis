cflags{
	'-std=gnu99', '-Wall',
	'-D _GNU_SOURCE',
	'-D CUBEB_GECKO_BUILD',
	'-D USE_ALSA',
	'-I $outdir/include',
	'-isystem $builddir/pkg/alsa-lib/include',
}

rule('cxx', '$cc -std=c++17 -MD -MF $out.d $cflags -x c++ -c -o $out $in', {
	depfile='$out.d',
	deps='gcc',
})

pkg.hdrs = {
	install = true,
	copy('$outdir/include/cubeb', '$srcdir/include/cubeb', {'cubeb.h'}),
	copy('$outdir/include/cubeb', '$dir', {'cubeb_export.h'}),
}

pkg.deps = {
	'$gendir/headers',
	'pkg/alsa-lib/headers',
}

ar('liblibcubeb.a', {
	compile('cc', 'src/cubeb.c'),
	compile('cc', 'src/cubeb_alsa.c'),
	compile('cxx', 'src/cubeb_panner.cpp'),
})

fetch 'curl'
