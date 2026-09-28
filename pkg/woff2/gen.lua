cflags{
	'-D __STDC_FORMAT_MACROS',
	'-I $dir/src/src',
	'-I $dir/src/include',
	'-isystem $builddir/pkg/brotli/include',
}

pkg.hdrs = copy('$outdir/include', '$srcdir/include', {
	'woff2/decode.h',
	'woff2/encode.h',
	'woff2/output.h',
})
pkg.hdrs.install = true
pkg.deps = {
	'pkg/brotli/headers',
}

local objs = {}
for src in iterpaths([=[
	src/(
		table_tags.cc variable_length.cc woff2_common.cc woff2_dec.cc woff2_out.cc
	)
]=]) do
	objs[#objs + 1] = compile('cc', src)
end
ar('libwoff2.a', objs)

fetch 'curl'
