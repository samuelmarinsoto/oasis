cflags{
	'-I $srcdir',
	'-D WEBP_HAVE_SSE2',
	'-D WEBP_HAVE_SSE41',
}

pkg.hdrs = copy('$outdir/include/webp', '$srcdir/src/webp', {
	'decode.h',
	'demux.h',
	'encode.h',
	'format_constants.h',
	'mux.h',
	'mux_types.h',
	'types.h',
})
pkg.hdrs.install = true

local objs = {}
for src in iterpaths([=[
	src/dec/(
		alpha_dec.c buffer_dec.c frame_dec.c idec_dec.c io_dec.c
		quant_dec.c tree_dec.c vp8_dec.c vp8l_dec.c webp_dec.c
	)
	src/demux/(
		demux.c
	)
	src/dsp/(
		alpha_processing.c cost.c cpu.c dec.c dec_clip_tables.c enc.c
		filters.c lossless.c lossless_enc.c rescaler.c ssim.c
		upsampling.c yuv.c

		alpha_processing_sse2.c cost_sse2.c dec_sse2.c enc_sse2.c
		filters_sse2.c lossless_enc_sse2.c lossless_sse2.c
		rescaler_sse2.c ssim_sse2.c upsampling_sse2.c yuv_sse2.c
	)
	src/enc/(
		alpha_enc.c analysis_enc.c backward_references_cost_enc.c
		backward_references_enc.c config_enc.c cost_enc.c filter_enc.c
		frame_enc.c histogram_enc.c iterator_enc.c near_lossless_enc.c
		picture_csp_enc.c picture_enc.c picture_psnr_enc.c
		picture_rescale_enc.c picture_tools_enc.c predictor_enc.c
		quant_enc.c syntax_enc.c token_enc.c tree_enc.c vp8l_enc.c
		webp_enc.c
	)
	src/utils/(
		bit_reader_utils.c bit_writer_utils.c color_cache_utils.c
		filters_utils.c huffman_encode_utils.c huffman_utils.c
		quant_levels_dec_utils.c quant_levels_utils.c random_utils.c
		rescaler_utils.c thread_utils.c utils.c
	)
]=]) do
	objs[#objs + 1] = compile('cc', src)
end
for src in iterpaths([=[
	src/dsp/(
		alpha_processing_sse41.c dec_sse41.c enc_sse41.c
		lossless_enc_sse41.c lossless_sse41.c upsampling_sse41.c
		yuv_sse41.c
	)
]=]) do
	objs[#objs + 1] = compile('cc', src, nil, {cflags='$cflags -msse4.1'})
end
ar('libwebp.a', objs)

file('lib/libwebp.a', '644', '$outdir/libwebp.a')

fetch 'curl'
