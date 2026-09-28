cflags{'-I $srcdir/c/include'}

pkg.hdrs = copy('$outdir/include', '$srcdir/c/include', {
	'brotli/decode.h',
	'brotli/encode.h',
	'brotli/port.h',
	'brotli/shared_dictionary.h',
	'brotli/types.h',
})
pkg.hdrs.install = true

local objs = {}
for src in iterpaths([=[
	c/common/(constants.c context.c dictionary.c platform.c shared_dictionary.c transform.c)
	c/dec/(bit_reader.c decode.c huffman.c prefix.c state.c static_init.c)
]=]) do
	objs[#objs + 1] = compile('cc', src)
end
ar('libbrotli.a', objs)

fetch 'curl'
