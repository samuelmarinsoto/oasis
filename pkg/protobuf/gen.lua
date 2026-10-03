-- google protobuf 2.6.1, the 2.x vintage the gecko consumers and their
-- checked-in .pb files are written against (modern protobuf is a
-- different library: never bump). Sources are the release tarball plus
-- mozilla's compiler-portability delta (patch/m-c-changes.patch); the
-- local fetch.sh strips the tarball root so $srcdir IS protobuf's src/.
--
-- gt (toolkit/components/protobuf/backend.mk) compiled exactly this set
-- with -D NDEBUG -D TRIMMED and the three backend defines below; no
-- config.h (the patched stubs select their own compiler quirks), no
-- protoc (the generated .pb files are checked into the gecko tree).
-- Unlike the gecko dialect this code uses dynamic_cast and throws:
-- rtti + exceptions stay on.
cflags{
	'-D NDEBUG',
	'-D TRIMMED=1',
	'-D GOOGLE_PROTOBUF_NO_STATIC_INITIALIZER',
	'-D HAVE_PTHREAD',
	'-D HAVE_PTHREAD_H',
	'-D HAVE_ZLIB',
	'-frtti',
	'-fexceptions',
	'-I $srcdir',
	'-isystem $outdir/include',
	'-isystem $builddir/pkg/zlib/include',
}

pkg.deps = {
	'pkg/zlib/headers',
	'pkg/uxp/fetch',
	'$gendir/mfbt',
}

lib('libprotobuf.a', [[
	google/protobuf/(
		descriptor.cc
		descriptor.pb.cc
		descriptor_database.cc
		dynamic_message.cc
		extension_set.cc
		extension_set_heavy.cc
		generated_message_reflection.cc
		generated_message_util.cc
		message.cc
		message_lite.cc
		reflection_ops.cc
		repeated_field.cc
		service.cc
		text_format.cc
		unknown_field_set.cc
		wire_format.cc
		wire_format_lite.cc
		io/(
			coded_stream.cc
			gzip_stream.cc
			printer.cc
			strtod.cc
			tokenizer.cc
			zero_copy_stream.cc
			zero_copy_stream_impl.cc
			zero_copy_stream_impl_lite.cc
		)
		stubs/(
			atomicops_internals_x86_gcc.cc
			atomicops_internals_x86_msvc.cc
			common.cc
			once.cc
			stringprintf.cc
			structurally_valid.cc
			strutil.cc
			substitute.cc
		)
	)
]])

-- stage the mfbt closure strutil.cc's mozilla/FloatingPoint.h include
-- pulls in, borrowed from the shared uxp checkout (the
-- pkg/uxp/libjpeg pattern)
pkg.deps[#pkg.deps + 1] = 'pkg/uxp/fetch'
phony('mfbt', copy('$outdir/include/mozilla', '$basedir/pkg/uxp/src/mfbt', {
	'Assertions.h',
	'Attributes.h',
	'Casting.h',
	'Compiler.h',
	'FloatingPoint.h',
	'Likely.h',
	'MacroArgs.h',
	'MathAlgorithms.h',
	'Move.h',
	'StaticAnalysisFunctions.h',
	'TypeTraits.h',
	'Types.h',
}))

-- export the gt dist/include/google/protobuf set (heapsnapshot's
-- CoreDump.pb.h, layerscope's LayerScopePacket.pb.h and the decoders
-- resolve <google/protobuf/*.h> through it); build-time only, never
-- installed into the rootfs
pkg.hdrs = copy('$outdir/include/google/protobuf', '$srcdir/google/protobuf', {
	'descriptor.h',
	'descriptor.pb.h',
	'descriptor_database.h',
	'dynamic_message.h',
	'extension_set.h',
	'generated_enum_reflection.h',
	'generated_message_reflection.h',
	'generated_message_util.h',
	'message.h',
	'message_lite.h',
	'package_info.h',
	'reflection_ops.h',
	'repeated_field.h',
	'service.h',
	'text_format.h',
	'unknown_field_set.h',
	'wire_format.h',
	'wire_format_lite.h',
	'wire_format_lite_inl.h',
	'io/coded_stream.h',
	'io/coded_stream_inl.h',
	'io/gzip_stream.h',
	'io/package_info.h',
	'io/printer.h',
	'io/strtod.h',
	'io/tokenizer.h',
	'io/zero_copy_stream.h',
	'io/zero_copy_stream_impl.h',
	'io/zero_copy_stream_impl_lite.h',
	'stubs/atomicops.h',
	'stubs/atomicops_internals_arm64_gcc.h',
	'stubs/atomicops_internals_arm_gcc.h',
	'stubs/atomicops_internals_arm_qnx.h',
	'stubs/atomicops_internals_atomicword_compat.h',
	'stubs/atomicops_internals_generic_gcc.h',
	'stubs/atomicops_internals_macosx.h',
	'stubs/atomicops_internals_mips_gcc.h',
	'stubs/atomicops_internals_pnacl.h',
	'stubs/atomicops_internals_solaris.h',
	'stubs/atomicops_internals_tsan.h',
	'stubs/atomicops_internals_x86_gcc.h',
	'stubs/atomicops_internals_x86_msvc.h',
	'stubs/common.h',
	'stubs/hash.h',
	'stubs/map_util.h',
	'stubs/once.h',
	'stubs/platform_macros.h',
	'stubs/shared_ptr.h',
	'stubs/stl_util.h',
	'stubs/stringprintf.h',
	'stubs/strutil.h',
	'stubs/substitute.h',
	'stubs/template_util.h',
	'stubs/type_traits.h',
})

fetch 'local'
