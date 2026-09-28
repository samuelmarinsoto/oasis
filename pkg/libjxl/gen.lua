rule('cxx', '$cc -std=c++11 -MD -MF $out.d $cflags -x c++ -c -o $out $in', {
	depfile='$out.d',
	deps='gcc',
})

cflags{
	'-I $outdir/include',
	'-I $srcdir/lib/include',
	'-I $srcdir',
	'-D JPEGXL_ENABLE_BOXES=0',
	'-D JPEGXL_ENABLE_TRANSCODE_JPEG=0',
}

build('sed', '$outdir/include/jxl/version.h', '$srcdir/lib/jxl/version.h.in', {
	expr=[[-e s,@JPEGXL_MAJOR_VERSION@,0, -e s,@JPEGXL_MINOR_VERSION@,11, -e s,@JPEGXL_PATCH_VERSION@,2,]],
})
build('copy', '$outdir/include/jxl/jxl_export.h', '$dir/jxl_export.h')
build('copy', '$outdir/include/jxl/jxl_threads_export.h', '$dir/jxl_threads_export.h')

pkg.hdrs = {
	copy('$outdir/include/jxl', '$srcdir/lib/include/jxl', {
		'cms.h', 'cms_interface.h', 'codestream_header.h', 'color_encoding.h',
		'compressed_icc.h', 'decode.h', 'decode_cxx.h', 'encode.h', 'encode_cxx.h',
		'gain_map.h', 'memory_manager.h', 'parallel_runner.h',
		'resizable_parallel_runner.h', 'resizable_parallel_runner_cxx.h', 'stats.h',
		'thread_parallel_runner.h', 'thread_parallel_runner_cxx.h', 'types.h',
	}),
	copy('$outdir/include/hwy', '$srcdir/hwy', {
		'aligned_allocator.h', 'base.h', 'cache_control.h',
		'detect_compiler_arch.h', 'detect_targets.h', 'foreach_target.h',
		'highway.h', 'highway_export.h', 'nanobenchmark.h', 'per_target.h',
		'print-inl.h', 'print.h', 'targets.h',
	}),
	copy('$outdir/include/hwy/ops', '$srcdir/hwy/ops', {
		'arm_neon-inl.h', 'arm_sve-inl.h', 'emu128-inl.h', 'generic_ops-inl.h',
		'rvv-inl.h', 'scalar-inl.h', 'set_macros-inl.h', 'shared-inl.h',
		'wasm_128-inl.h', 'wasm_256-inl.h', 'x86_128-inl.h', 'x86_256-inl.h',
		'x86_512-inl.h',
	}),
	copy('$outdir/include/hwy/contrib/image', '$srcdir/hwy/contrib/image', {
		'image.h',
	}),
	'$outdir/include/jxl/version.h',
	'$outdir/include/jxl/jxl_export.h',
	'$outdir/include/jxl/jxl_threads_export.h',
	install=true,
}
pkg.deps = {'$gendir/headers'}

local function isaflags(src)
	if src:find('avx512') or src:find('__avx3') then
		return '-mavx512f -mavx512dq -mavx512bw -mavx512vl'
	elseif src:find('avx2') then
		return '-mavx2'
	elseif src:find('sse4') then
		return '-msse4.1'
	end
end

local function compilecxx(src)
	local flags = isaflags(src)
	if flags then
		return compile('cxx', src, nil, {cflags='$cflags '..flags})
	end
	return compile('cxx', src)
end

local jxlobjs = {}
for src in iterpaths([=[
	lib/jxl/(
		ac_strategy.cc alpha.cc ans_common.cc blending.cc
		chroma_from_luma.cc coeff_order.cc color_encoding_internal.cc
		compressed_dc.cc convolve_separable5.cc convolve_slow.cc
		convolve_symmetric3.cc convolve_symmetric5.cc dct_scales.cc
		dec_ans.cc dec_cache.cc dec_context_map.cc dec_external_image.cc
		dec_frame.cc dec_group.cc dec_group_border.cc dec_huffman.cc
		dec_modular.cc dec_noise.cc dec_patch_dictionary.cc dec_xyb.cc
		decode.cc entropy_coder.cc epf.cc fields.cc frame_header.cc
		headers.cc huffman_table.cc icc_codec.cc icc_codec_common.cc
		image.cc image_bundle.cc image_metadata.cc image_ops.cc
		loop_filter.cc luminance.cc memory_manager_internal.cc
		opsin_params.cc passes_state.cc quant_weights.cc quantizer.cc
		simd_util.cc splines.cc test_memory_manager.cc toc.cc
		modular/(modular_image.cc)
		modular/encoding/(dec_ma.cc encoding.cc)
		modular/transform/(palette.cc rct.cc squeeze.cc transform.cc)
		render_pipeline/(
			low_memory_render_pipeline.cc render_pipeline.cc
			simple_render_pipeline.cc stage_blending.cc
			stage_chroma_upsampling.cc stage_cms.cc stage_epf.cc
			stage_from_linear.cc stage_gaborish.cc stage_noise.cc
			stage_patches.cc stage_splines.cc stage_spot.cc
			stage_to_linear.cc stage_tone_mapping.cc stage_upsampling.cc
			stage_write.cc stage_xyb.cc stage_ycbcr.cc
		)
	)
	lib/threads/(thread_parallel_runner.cc thread_parallel_runner_internal.cc)
]=]) do
	jxlobjs[#jxlobjs + 1] = compilecxx(src)
end
ar('libjxl.a', jxlobjs)

local hwyobjs = {}
for src in iterpaths([=[
	hwy/(aligned_allocator.cc per_target.cc targets.cc)
	hwy/contrib/image/(image.cc)
]=]) do
	hwyobjs[#hwyobjs + 1] = compilecxx(src)
end
ar('libhwy.a', hwyobjs)

fetch 'curl'
