cflags{
	'-D HAVE_CONFIG_H=vpx_config.h',
	'-D __x86_64__',
	'-Wno-sign-compare',
	'-Wno-unused-function',
	'-I $dir',
	'-I $srcdir',
}
nasmflags{
	'-i $dir/',
	'-i $srcdir/',
	'-f elf64',
}

pkg.hdrs = {
	copy('$outdir/include/vpx', '$srcdir/vpx', paths([[
		vp8.h vp8cx.h vp8dx.h vpx_codec.h vpx_decoder.h vpx_encoder.h
		vpx_ext_ratectrl.h vpx_frame_buffer.h vpx_image.h vpx_integer.h
		vpx_tpl.h
	]])),
	copy('$outdir/include', '$dir', {
		'vp8_rtcd.h',
		'vp9_rtcd.h',
		'vpx_config.h',
		'vpx_dsp_rtcd.h',
		'vpx_scale_rtcd.h',
		'vpx_version.h',
	}),
	install=true,
}
pkg.deps = {
	'$gendir/headers',
}

local srcs = [[
	vp8/(
		vp8_cx_iface.c vp8_dx_iface.c
		common/(
			alloccommon.c blockd.c dequantize.c entropy.c entropymode.c
			entropymv.c extend.c filter.c findnearmv.c idct_blk.c idctllm.c
			loopfilter_filters.c mbpitch.c mfqe.c modecont.c postproc.c
			quant_common.c reconinter.c reconintra.c reconintra4x4.c rtcd.c
			setupintrarecon.c swapyv12buffer.c treecoder.c vp8_loopfilter.c
			vp8_skin_detection.c
			generic/(systemdependent.c)
			x86/(
				bilinear_filter_sse2.c idct_blk_mmx.c idct_blk_sse2.c
				loopfilter_x86.c vp8_asm_stubs.c
				dequantize_mmx.asm idctllm_mmx.asm idctllm_sse2.asm
				iwalsh_sse2.asm loopfilter_block_sse2_x86_64.asm
				loopfilter_sse2.asm mfqe_sse2.asm recon_mmx.asm recon_sse2.asm
				subpixel_mmx.asm subpixel_sse2.asm subpixel_ssse3.asm
			)
		)
		decoder/(
			dboolhuff.c decodeframe.c decodemv.c detokenize.c onyxd_if.c
			threading.c
		)
		encoder/(
			bitstream.c boolhuff.c copy_c.c dct.c denoising.c encodeframe.c
			encodeintra.c encodemb.c encodemv.c ethreading.c firstpass.c
			lookahead.c mcomp.c modecosts.c mr_dissim.c onyx_if.c pickinter.c
			picklpf.c ratectrl.c rdopt.c segmentation.c temporal_filter.c
			tokenize.c treewriter.c vp8_quantize.c
			x86/(
				denoising_sse2.c quantize_sse4.c vp8_enc_stubs_sse2.c
				vp8_quantize_sse2.c vp8_quantize_ssse3.c
				block_error_sse2.asm copy_sse2.asm copy_sse3.asm dct_sse2.asm
				fwalsh_sse2.asm temporal_filter_apply_sse2.asm
			)
		)
	)
	vp9/(
		vp9_cx_iface.c vp9_dx_iface.c vp9_iface_common.c
		common/(
			vp9_alloccommon.c vp9_blockd.c vp9_common_data.c vp9_entropy.c
			vp9_entropymode.c vp9_entropymv.c vp9_filter.c vp9_frame_buffers.c
			vp9_idct.c vp9_loopfilter.c vp9_mfqe.c vp9_mvref_common.c
			vp9_postproc.c vp9_pred_common.c vp9_quant_common.c
			vp9_reconinter.c vp9_reconintra.c vp9_rtcd.c vp9_scale.c vp9_scan.c
			vp9_seg_common.c vp9_thread_common.c vp9_tile_common.c
			x86/(vp9_idct_intrin_sse2.c vp9_mfqe_sse2.asm)
		)
		decoder/(
			vp9_decodeframe.c vp9_decodemv.c vp9_decoder.c vp9_detokenize.c
			vp9_dsubexp.c vp9_job_queue.c
		)
		encoder/(
			vp9_alt_ref_aq.c vp9_aq_360.c vp9_aq_complexity.c
			vp9_aq_cyclicrefresh.c vp9_aq_variance.c vp9_bitstream.c
			vp9_context_tree.c vp9_cost.c vp9_dct.c vp9_encodeframe.c
			vp9_encodemb.c vp9_encodemv.c vp9_encoder.c vp9_ethread.c
			vp9_ext_ratectrl.c vp9_extend.c vp9_firstpass.c vp9_frame_scale.c
			vp9_lookahead.c vp9_mbgraph.c vp9_mcomp.c vp9_multi_thread.c
			vp9_noise_estimate.c vp9_picklpf.c vp9_pickmode.c vp9_quantize.c
			vp9_ratectrl.c vp9_rd.c vp9_rdopt.c vp9_resize.c vp9_segmentation.c
			vp9_skin_detection.c vp9_speed_features.c vp9_subexp.c
			vp9_svc_layercontext.c vp9_temporal_filter.c vp9_tokenize.c
			vp9_tpl_model.c vp9_treewriter.c
			x86/(
				temporal_filter_avx2.c temporal_filter_sse4.c
				temporal_filter_ssse3.c vp9_dct_intrin_sse2.c vp9_error_avx2.c
				vp9_frame_scale_ssse3.c vp9_quantize_avx2.c vp9_quantize_sse2.c
				vp9_quantize_ssse3.c
				vp9_dct_sse2.asm vp9_error_sse2.asm
			)
		)
	)
	vpx/(src/(vpx_codec.c vpx_decoder.c vpx_encoder.c vpx_image.c))
	vpx_dsp/(
		add_noise.c avg.c bitreader.c bitreader_buffer.c bitwriter.c
		bitwriter_buffer.c deblock.c fwd_txfm.c intrapred.c inv_txfm.c
		loopfilter.c prob.c psnr.c quantize.c sad.c skin_detection.c sse.c
		subtract.c sum_squares.c variance.c vpx_convolve.c vpx_dsp_rtcd.c
		x86/(
			avg_intrin_avx2.c avg_intrin_sse2.c avg_pred_avx2.c avg_pred_sse2.c
			fwd_txfm_avx2.c fwd_txfm_sse2.c inv_txfm_avx2.c inv_txfm_sse2.c
			inv_txfm_ssse3.c loopfilter_avx2.c loopfilter_sse2.c
			post_proc_sse2.c quantize_avx.c quantize_avx2.c quantize_sse2.c
			quantize_ssse3.c sad4d_avx2.c sad4d_avx512.c sad_avx2.c
			sad_avx512.c sse_avx2.c sse_sse4.c subtract_avx2.c
			sum_squares_sse2.c variance_avx2.c variance_sse2.c
			vpx_subpixel_4t_intrin_sse2.c vpx_subpixel_8t_intrin_avx2.c
			vpx_subpixel_8t_intrin_ssse3.c
			add_noise_sse2.asm avg_ssse3_x86_64.asm deblock_sse2.asm
			fwd_txfm_ssse3_x86_64.asm intrapred_sse2.asm intrapred_ssse3.asm
			inv_wht_sse2.asm sad4d_sse2.asm sad_sse2.asm ssim_opt_x86_64.asm
			subpel_variance_sse2.asm subtract_sse2.asm
			vpx_convolve_copy_sse2.asm vpx_subpixel_8t_sse2.asm
			vpx_subpixel_8t_ssse3.asm vpx_subpixel_bilinear_sse2.asm
			vpx_subpixel_bilinear_ssse3.asm
		)
	)
	vpx_mem/(vpx_mem.c)
	vpx_ports/(emms_mmx.asm x86_abi_support.asm)
	vpx_scale/(
		generic/(gen_scalers.c vpx_scale.c yv12config.c yv12extend.c)
		vpx_scale_rtcd.c
	)
	vpx_util/(vpx_thread.c vpx_write_yuv_frame.c)
]]

local function isacflags(src)
	if src:find('avx512') then
		return ' -mavx512f -mavx512cd -mavx512vl -mavx512dq -mavx512bw'
	elseif src:find('avx2') then
		return ' -mavx2'
	elseif src:find('avx') then
		return ' -mavx'
	elseif src:find('ssse3') then
		return ' -mssse3'
	elseif src:find('sse4_2') then
		return ' -msse4.2'
	elseif src:find('sse4') or src:find('sse41') then
		return ' -msse4.1'
	end
	return ''
end

local objs = {}
for src in iterpaths(srcs) do
	if src:find('%.asm$') then
		objs[#objs + 1] = compile('nasm', src)
	else
		local flags = isacflags(src)
		objs[#objs + 1] = compile('cc', src, nil, flags ~= '' and {cflags='$cflags'..flags} or nil)
	end
end
ar('libvpx.a', objs)

fetch 'curl'
