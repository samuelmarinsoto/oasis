-- libyuv (YUV/RGB pixel conversion), a standalone package built from its
-- own upstream at the commit UXP's vendored copy (pkg/uxp/src/media/libyuv)
-- is based on; UXP's local changes ride along as the patch series under
-- patch/. The vendored tree is the version reference and patch ground
-- truth, not the source we ship.
cflags{
	'-I $srcdir/include',
}

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/include', {'libyuv.h'}),
	copy('$outdir/include', '$srcdir/include', paths [[libyuv/(
		basic_types.h
		compare.h
		compare_row.h
		convert.h
		convert_argb.h
		convert_from.h
		convert_from_argb.h
		cpu_id.h
		loongson_intrinsics.h
		macros_msa.h
		mjpeg_decoder.h
		planar_functions.h
		rotate.h
		rotate_argb.h
		rotate_row.h
		row.h
		scale.h
		scale_argb.h
		scale_rgb.h
		scale_row.h
		scale_uv.h
		version.h
		video_common.h
	)]]),
}
pkg.hdrs.install = true

-- Core conversion set from upstream's BUILD.gn (libyuv_internal):
-- portable C plus the gcc SIMD variants, HAVE_JPEG off. The x86 intrinsics
-- compile at baseline ISA; the *_win.cc files are MSVC-guarded no-ops here.
lib('liblibyuv.a', [[source/(
	compare.cc
	compare_common.cc
	compare_gcc.cc
	compare_win.cc
	convert.cc
	convert_argb.cc
	convert_from.cc
	convert_from_argb.cc
	convert_jpeg.cc
	convert_to_argb.cc
	convert_to_i420.cc
	cpu_id.cc
	mjpeg_decoder.cc
	mjpeg_validate.cc
	planar_functions.cc
	rotate.cc
	rotate_any.cc
	rotate_argb.cc
	rotate_common.cc
	rotate_gcc.cc
	rotate_win.cc
	row_any.cc
	row_common.cc
	row_gcc.cc
	row_win.cc
	scale.cc
	scale_any.cc
	scale_argb.cc
	scale_common.cc
	scale_gcc.cc
	scale_rgb.cc
	scale_uv.cc
	scale_win.cc
	video_common.cc
)]])

fetch 'curl'
