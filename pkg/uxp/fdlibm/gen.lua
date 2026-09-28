set('srcdir', '$basedir/pkg/uxp/src/modules/fdlibm')
cflags{
	'-std=c++17',
	'-Wno-parentheses',
	'-Wno-sign-compare',
	'-I $outdir/include',
}

local mbtdeps = {}
for _, hdr in ipairs({
	'Assertions.h',
	'Attributes.h',
	'Compiler.h',
	'DebugOnly.h',
	'EndianUtils.h',
	'Likely.h',
	'MacroArgs.h',
	'StaticAnalysisFunctions.h',
	'TypeTraits.h',
	'Types.h',
}) do
	local out = '$outdir/include/mozilla/'..hdr
	local src = '$basedir/pkg/uxp/src/mfbt/'..hdr
	mbtdeps[#mbtdeps + 1] = out
	build('copy', out, src)
end

pkg.hdrs = copy('$outdir/include', '$srcdir/src', {
	'fdlibm.h',
	'math_private.h',
})
pkg.hdrs.install = true

pkg.deps = {
	'pkg/uxp/fetch',
}

ar('libfdlibm.a', objects([[src/(
	e_acos.cpp
	e_acosh.cpp
	e_asin.cpp
	e_atan2.cpp
	e_atanh.cpp
	e_cosh.cpp
	e_exp.cpp
	e_hypot.cpp
	e_log.cpp
	e_log10.cpp
	e_log2.cpp
	e_pow.cpp
	e_sinh.cpp
	k_exp.cpp
	s_asinh.cpp
	s_atan.cpp
	s_cbrt.cpp
	s_ceil.cpp
	s_ceilf.cpp
	s_copysign.cpp
	s_expm1.cpp
	s_fabs.cpp
	s_floor.cpp
	s_floorf.cpp
	s_log1p.cpp
	s_nearbyint.cpp
	s_rint.cpp
	s_rintf.cpp
	s_scalbn.cpp
	s_tanh.cpp
	s_trunc.cpp
	s_truncf.cpp
)]], mbtdeps))

build('phony', table.keys(pkg.inputs.fetch), 'pkg/uxp/fetch');
