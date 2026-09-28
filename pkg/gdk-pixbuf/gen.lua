cflags{
	'-D HAVE_CONFIG_H',
	'-include $dir/config.h',
	'-I $dir',
	'-I $outdir/include/gdk-pixbuf-2.0',
	'-I $outdir/include/glib-2.0',
	'-isystem $builddir/pkg/glib/include/glib-2.0',
	'-isystem $builddir/pkg/glib/include/glib-2.0/glib',
	'-isystem $builddir/pkg/glib/src/glib',
	'-isystem $builddir/pkg/libpng/include',
	'-isystem $builddir/pkg/zlib/include',
	'-isystem $builddir/pkg/gmodule/include/glib-2.0',
	'-isystem $builddir/pkg/gio/include/glib-2.0',
	'-isystem $builddir/pkg/glib/include/glib-2.0/glib',
	'-D GDK_PIXBUF_COMPILATION',
	'-D G_LOG_DOMAIN="GdkPixbuf"',
	'-D GDK_PIXBUF_ENABLE_BACKEND',
	'-include $dir/logdomain.h',
}

pkg.hdrs = {
	copy('$outdir/include/gdk-pixbuf-2.0/gdk-pixbuf', '$dir', {'gdk-pixbuf-features.h', 'gdk-pixbuf-enum-types.h', 'gdk-pixbuf-marshal.h'}),
	copy('$outdir/include/gdk-pixbuf-2.0/gdk-pixbuf', '$srcdir/gdk-pixbuf', paths([[
		gdk-pixbuf.h gdk-pixbuf-core.h gdk-pixbuf-io.h gdk-pixbuf-loader.h
		gdk-pixbuf-macros.h gdk-pixbuf-transform.h gdk-pixbuf-animation.h
		gdk-pixbuf-simple-anim.h gdk-pixdata.h gdk-pixbuf-autocleanups.h
	]])),
	install=true,
}
pkg.deps = {
	'$gendir/headers',
	'pkg/glib/headers',
	'pkg/gmodule/headers',
	'pkg/gio/headers',
}

local gobjs = {}
for src in iterpaths([=[gdk-pixbuf/(
	gdk-pixbuf.c
	gdk-pixbuf-animation.c
	gdk-pixbuf-data.c
	gdk-pixbuf-io.c
	gdk-pixbuf-loader.c
	gdk-pixbuf-scale.c
	gdk-pixbuf-simple-anim.c
	gdk-pixbuf-util.c
	gdk-pixbuf-pixdata.c
	gdk-pixdata.c
	gdk-pixbuf-buffer-queue.c
	gdk-pixbuf-scaled-anim.c
	io-png.c
	io-ico.c
	io-bmp.c
	io-pnm.c
	io-xbm.c
	io-xpm.c
	io-icns.c
	io-ani.c
	io-ani-animation.c
	io-gif.c
	io-gif-animation.c
	io-tga.c
	io-qtif.c
	lzw.c
	pixops/pixops.c
)]=]) do
	gobjs[#gobjs + 1] = compile('cc', src)
end
gobjs[#gobjs + 1] = compile('cc', '$dir/gdk-pixbuf-enum-types.c')
gobjs[#gobjs + 1] = compile('cc', '$dir/gpb-enum.c')
gobjs[#gobjs + 1] = compile('cc', '$dir/gdk-pixbuf-marshal.c')
gobjs[#gobjs + 1] = '$builddir/pkg/glib/libglib-2.0.a'
gobjs[#gobjs + 1] = '$builddir/pkg/glib/libgobject-2.0.a'
gobjs[#gobjs + 1] = '$builddir/pkg/gmodule/libgmodule-2.0.a'
gobjs[#gobjs + 1] = '$builddir/pkg/libpng/libpng.a'
gobjs[#gobjs + 1] = '$builddir/pkg/zlib/libz.a'
ar('libgdk_pixbuf-2.0.a', gobjs)

fetch 'local'
