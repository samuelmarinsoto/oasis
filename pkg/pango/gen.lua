cflags{
	'-D HAVE_CONFIG_H',
	'-I $dir',
	'-I $srcdir/pango',
	'-I $outdir/include/pango-1.0',
	'-I $outdir/include/pango-1.0/pango',
	'-I $builddir/pkg/gio/include/glib-2.0',
	'-I $builddir/pkg/glib/include/glib-2.0',
	'-isystem $builddir/pkg/cairo/include',
	'-isystem $builddir/pkg/freetype/include',
	'-isystem $builddir/pkg/fontconfig/include',
	'-isystem $builddir/pkg/harfbuzz/include',
	'-isystem $builddir/pkg/glib/include/glib-2.0',
	'-isystem $srcdir/harfbuzz',
	'-isystem $builddir/pkg/fribidi/include',
	'-D PANGO_COMPILATION',
	'-D PANGO_ENABLE_ENGINE',
	'-D PANGO_ENABLE_BACKEND',
	'-D CAIRO_HAS_FT_FONT=1',
	'-D HAVE_CAIRO_FREETYPE=1',
	'-include $dir/logdomain.h',
	'-D GLIB_DISABLE_DEPRECATION_WARNINGS',
	'-Wno-error=int-conversion',
	'-Wno-error=incompatible-pointer-types',
}

local hdrnames = {}
for line in iterlines('hdrs.txt') do
	for h in line:gmatch('%S+') do
		hdrnames[#hdrnames + 1] = h
	end
end
local srcnames = {}
for line in iterlines('srcs.txt') do
	for s in line:gmatch('%S+') do
		srcnames[#srcnames + 1] = s
	end
end

build('copy', '$outdir/include/pango-1.0/pango/pango-features.h', '$dir/pango-features.h')
build('copy', '$outdir/include/pango-1.0/pango/pango-enum-types.h', '$dir/pango-enum-types.h')

pkg.hdrs = {
	copy('$outdir/include/pango-1.0/pango', '$srcdir/pango', hdrnames),
	'$outdir/include/pango-1.0/pango/pango-features.h',
	'$outdir/include/pango-1.0/pango/pango-enum-types.h',
	install=true,
}
pkg.deps = {
	'$gendir/headers',
	'$outdir/include/pango-1.0/pango/pango-features.h',
	'pkg/glib/headers',
	'pkg/gio/headers',
	'pkg/fribidi/headers',
	'pkg/harfbuzz/headers',
	'pkg/cairo/headers',
	'pkg/freetype/headers',
	'pkg/fontconfig/headers',
}

local gobjs = {}
for _, s in ipairs(srcnames) do
	gobjs[#gobjs + 1] = compile('cc', 'pango/' .. s)
end
gobjs[#gobjs + 1] = compile('cc', '$dir/pango-enum-types.c')
gobjs[#gobjs + 1] = '$builddir/pkg/glib/libglib-2.0.a'
gobjs[#gobjs + 1] = '$builddir/pkg/glib/libgobject-2.0.a'
gobjs[#gobjs + 1] = '$builddir/pkg/fribidi/libfribidi.a'
gobjs[#gobjs + 1] = '$builddir/pkg/harfbuzz/libharfbuzz.a'
gobjs[#gobjs + 1] = '$builddir/pkg/cairo/libcairo.a'
gobjs[#gobjs + 1] = '$builddir/pkg/freetype/libfreetype.a'
gobjs[#gobjs + 1] = '$builddir/pkg/fontconfig/libfontconfig.a'
gobjs[#gobjs + 1] = '$builddir/pkg/pixman/libpixman.a'
gobjs[#gobjs + 1] = '$builddir/pkg/libpng/libpng.a'
gobjs[#gobjs + 1] = '$builddir/pkg/zlib/libz.a'
ar('libpango-1.0.a', gobjs)

fetch 'local'
