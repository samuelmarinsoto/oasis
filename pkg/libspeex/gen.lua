-- Speex DSP resampler (cubeb's audio resampling). Upstream speexdsp release
-- matching the UXP pin (media/libspeex_resampler is speexdsp d60e75b2,
-- contained in 1.2rc2) plus UXP's resampler patch series; source list and
-- defines per UXP media/libspeex_resampler/moz.build: floating point samples,
-- SSE/SSE2 kernels picked at runtime through simd_detect (needs mozilla/SSE.h,
-- committed verbatim under include/mozilla). OUTSIDE_SPEEX compiles the
-- speexdsp_types.h include out of arch.h; the committed include/speex header
-- is provided for consumers building without it.
cflags{
	'-D OUTSIDE_SPEEX',
	'-D EXPORT=',
	'-D FLOATING_POINT',
	'-D _USE_SSE',
	'-D _USE_SSE2',
	'-Wno-sign-compare',
	'-I $dir/include',
	'-I $srcdir/libspeexdsp',
	'-I $srcdir/include/speex',
}

build('copy', '$outdir/include/speex/speex_resampler.h', '$srcdir/include/speex/speex_resampler.h')
build('copy', '$outdir/include/speex/speexdsp_types.h', '$dir/include/speex/speexdsp_types.h')

pkg.hdrs = {
	'$outdir/include/speex/speex_resampler.h',
	'$outdir/include/speex/speexdsp_types.h',
	install=true,
}

local objs = {}
objs[#objs + 1] = compile('cc', 'libspeexdsp/resample.c')
objs[#objs + 1] = compile('cc', 'libspeexdsp/resample_sse.c', nil, {cflags='$cflags -msse2'})
objs[#objs + 1] = compile('cc', 'libspeexdsp/simd_detect.cpp')
ar('libspeex.a', objs)

fetch 'curl'
