-- Theora video codec, decoder-only static library for pkg/palemoon.
-- Mirrors the UXP vendored build (media/libtheora/moz.build at the
-- e59e88bfd5 pin): libtheora 1.2.0, THEORA_DISABLE_ENCODE, and on x86
-- the OC_X86_ASM backend (1.2.0 ships it as C files, not .asm).
local arch = config.target.platform:match('[^-]*')
local x86 = arch:find('^x86') ~= nil

cflags{
	'-D HAVE_CONFIG_H',
	'-D THEORA_DISABLE_ENCODE',
	'-I $dir',
	'-I $srcdir/include',
	'-isystem $builddir/pkg/libogg/include',
	'-Wno-type-limits',
}
if x86 then
	cflags{
		'-D OC_X86_ASM',
	}
	if arch == 'x86_64' then
		cflags{
			'-D OC_X86_64_ASM',
		}
	end
end

pkg.hdrs = {
	copy('$outdir/include/theora', '$srcdir/include/theora', paths([[
		codec.h theora.h theoradec.h theoraenc.h
	]])),
	install=true,
}
pkg.deps = {
	'$gendir/headers',
	'pkg/libogg/headers',
}

local objs = {}
for src in iterpaths([=[
	lib/(
		bitpack.c decinfo.c decode.c dequant.c fragment.c huffdec.c
		idct.c info.c internal.c quant.c state.c
	)
]=]) do
	objs[#objs + 1] = compile('cc', src)
end
if x86 then
	for src in iterpaths([=[
		lib/x86/(
			mmxfrag.c mmxidct.c mmxstate.c sse2idct.c x86cpu.c
			x86state.c
		)
	]=]) do
		objs[#objs + 1] = compile('cc', src)
	end
end
ar('libtheora.a', objs)

fetch 'curl'
