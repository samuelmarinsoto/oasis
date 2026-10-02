-- libjpeg (IJG libjpeg with libjpeg-turbo nasm SIMD), compiled from the
-- shared UXP checkout that pkg/uxp fetches (see pkg/uxp/psshparser for
-- the borrowed-sources pattern).
set('srcdir', '$basedir/pkg/uxp/src/media/libjpeg')

cflags{
	'-D NDEBUG',
	'-I $srcdir',
	'-isystem $outdir/include',
}
nasmflags{
	'-f elf64',
	'-D__x86_64__',
	'-DPIC',
	'-DELF',
	'-i $srcdir/simd/nasm/',
	'-i $srcdir/simd/x86_64/',
}

pkg.deps = {
	'pkg/uxp/fetch',
	'$gendir/mfbt',
}

-- source list per media/libjpeg/moz.build (x86_64): scalar and SIMD
-- variants both compile, runtime dispatch lives in jsimd.c/jsimdcpu.asm
local objs = objects([[
	jcapimin.c jcapistd.c jccoefct.c jccolor.c jcdctmgr.c jchuff.c
	jcicc.c jcinit.c jcmainct.c jcmarker.c jcmaster.c jcomapi.c
	jcparam.c jcphuff.c jcprepct.c jcsample.c jctrans.c
	jdapimin.c jdapistd.c jdatadst.c jdatasrc.c jdcoefct.c jdcolor.c
	jddctmgr.c jdhuff.c jdicc.c jdinput.c jdmainct.c jdmarker.c
	jdmaster.c jdmerge.c jdphuff.c jdpostct.c jdsample.c jdtrans.c
	jerror.c jfdctflt.c jfdctfst.c jfdctint.c jidctflt.c jidctfst.c
	jidctint.c jidctred.c jmemmgr.c jmemnobs.c jquant1.c jquant2.c
	jutils.c
	simd/x86_64/(
		jccolor-avx2.asm jccolor-sse2.asm jcgray-avx2.asm
		jcgray-sse2.asm jchuff-sse2.asm jcphuff-sse2.asm
		jcsample-avx2.asm jcsample-sse2.asm jdcolor-avx2.asm
		jdcolor-sse2.asm jdmerge-avx2.asm jdmerge-sse2.asm
		jdsample-avx2.asm jdsample-sse2.asm jfdctflt-sse.asm
		jfdctfst-sse2.asm jfdctint-avx2.asm jfdctint-sse2.asm
		jidctflt-sse2.asm jidctfst-sse2.asm jidctint-avx2.asm
		jidctint-sse2.asm jidctred-sse2.asm jquantf-sse2.asm
		jquanti-avx2.asm jquanti-sse2.asm jsimd.c jsimdcpu.asm
	)
]])
ar('libjpeg.a', objs)

-- stage the mfbt include closure that jconfigint.h uses (mozilla/*.h
-- layout), as pkg/uxp/psshparser does
phony('mfbt', copy('$outdir/include/mozilla', '$basedir/pkg/uxp/src/mfbt', {
	'Assertions.h',
	'Attributes.h',
	'Compiler.h',
	'DebugOnly.h',
	'EndianUtils.h',
	'Likely.h',
	'MacroArgs.h',
	'Move.h',
	'StaticAnalysisFunctions.h',
	'TypeTraits.h',
	'Types.h',
}))

pkg.hdrs = copy('$outdir/include', '$srcdir', {
	'jconfig.h',
	'jconfigint.h',
	'jdct.h',
	'jerror.h',
	'jinclude.h',
	'jmorecfg.h',
	'jpegint.h',
	'jpeglib.h',
})
pkg.hdrs.install = true
