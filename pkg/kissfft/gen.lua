pkg.hdrs = {
	copy('$outdir/include', '$srcdir', {'kiss_fft.h', 'kiss_fftr.h', '_kiss_fft_guts.h'}),
	install=true,
}

lib('libkissfft.a', {
	'kiss_fft.c',
	'kiss_fftr.c',
})

fetch 'curl'
