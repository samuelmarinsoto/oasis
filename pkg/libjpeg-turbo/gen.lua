cflags{
	'-I $outdir',
	'-I $outdir/include',
}

nasmflags{
	'-f elf64',
	'-DELF',
	'-DPIC',
	'-D__x86_64__',
	'-i $srcdir/simd/nasm/',
	'-i $srcdir/simd/x86_64/',
}

build('cat', '$outdir/jconfigint.h', {
	'$builddir/probe/HAVE__THREAD_LOCAL',
	'$builddir/probe/HAVE___BUILTIN_CTZL',
	'$dir/jconfigint.h',
})

pkg.deps = {
	'$gendir/headers',
	'$outdir/jconfigint.h',
}

-- SIMD dispatch per src/simd/CMakeLists.txt (x86_64): jsimd.c is the
-- runtime CPUID dispatcher, jsimdcpu.asm the CPU feature probe; the
-- jccolext/jcgryext/jdcolext/jdmrgext .asm files are assembly-time
-- %include fragments of the -sse2/-avx2 parents, not objects
lib('libjpeg-turbo.a', [[
	jcapimin.c jcapistd.c jccoefct.c jccolor.c jcdctmgr.c jchuff.c
	jcicc.c jcinit.c jcmainct.c jcmarker.c jcmaster.c jcomapi.c jcparam.c
	jcphuff.c jcprepct.c jcsample.c jctrans.c jdapimin.c jdapistd.c jdatadst.c
	jdatasrc.c jdcoefct.c jdcolor.c jddctmgr.c jdhuff.c jdicc.c jdinput.c
	jdmainct.c jdmarker.c jdmaster.c jdmerge.c jdphuff.c jdpostct.c jdsample.c
	jdtrans.c jerror.c jfdctflt.c jfdctfst.c jfdctint.c jidctflt.c jidctfst.c
	jidctint.c jidctred.c jquant1.c jquant2.c jutils.c jmemmgr.c jmemnobs.c

	jaricom.c jcarith.c jdarith.c

	simd/x86_64/(
		jsimd.c jsimdcpu.asm jfdctflt-sse.asm
		jccolor-sse2.asm jcgray-sse2.asm jchuff-sse2.asm
		jcphuff-sse2.asm jcsample-sse2.asm jdcolor-sse2.asm
		jdmerge-sse2.asm jdsample-sse2.asm jfdctfst-sse2.asm
		jfdctint-sse2.asm jidctflt-sse2.asm jidctfst-sse2.asm
		jidctint-sse2.asm jidctred-sse2.asm jquantf-sse2.asm
		jquanti-sse2.asm jccolor-avx2.asm jcgray-avx2.asm
		jcsample-avx2.asm jdcolor-avx2.asm jdmerge-avx2.asm
		jdsample-avx2.asm jfdctint-avx2.asm jidctint-avx2.asm
		jquanti-avx2.asm
	)
]])

pkg.hdrs = {
	copy('$outdir/include', '$srcdir', {'jerror.h', 'jmorecfg.h', 'jpeglib.h'}),
	copy('$outdir/include', '$dir', {'jconfig.h'}),
}

fetch 'git'
