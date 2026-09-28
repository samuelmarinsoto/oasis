cflags{
	'-D ST_NO_EXCEPTION_HANDLING=1',
	'-I $srcdir/include',
}

pkg.hdrs = {
	copy('$outdir/include/soundtouch', '$srcdir/include', paths([[
		SoundTouch.h STTypes.h FIFOSamplePipe.h
	]])),
	copy('$outdir/include/soundtouch', '$dir', paths([[
		SoundTouchFactory.h soundtouch_config.h
	]])),
	install=true,
}
pkg.deps = {
	'$gendir/headers',
}

local objs = {}
for src in iterpaths([=[
	source/SoundTouch/(
		AAFilter.cpp FIFOSampleBuffer.cpp FIRFilter.cpp
		InterpolateCubic.cpp InterpolateLinear.cpp InterpolateShannon.cpp
		RateTransposer.cpp SoundTouch.cpp TDStretch.cpp cpu_detect_x86.cpp
	)
]=]) do
	objs[#objs + 1] = compile('cc', src)
end
objs[#objs + 1] = compile('cc', 'source/SoundTouch/sse_optimized.cpp', nil, {cflags='$cflags -msse2'})
objs[#objs + 1] = compile('cc', '$dir/SoundTouchFactory.cpp', '$gendir/headers', {cflags='$cflags -I $outdir/include'})
ar('libsoundtouch.a', objs)

fetch 'curl'
