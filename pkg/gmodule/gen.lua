cflags{
	'-D HAVE_CONFIG_H',
	'-D SIZEOF_CHAR=1',
	'-D SIZEOF_SHORT=2',
	'-D SIZEOF_INT=4',
	'-D SIZEOF_LONG=8',
	'-I $dir',
	'-I $builddir/pkg/glib/include/glib-2.0',
	'-I $builddir/pkg/glib/include/glib-2.0/glib',
	'-I $outdir/include/glib-2.0',
	'-include $dir/logdomain.h',
	'-D G_MODULE_COMPILATION',
}
build('copy', '$outdir/include/glib-2.0/gmodule.h', '$srcdir/gmodule/gmodule.h')
pkg.hdrs = {
	copy('$outdir/include/glib-2.0', '$dir', {'gmoduleconf.h'}),
	'$outdir/include/glib-2.0/gmodule.h',
	install=true,
}
pkg.deps = {'$gendir/headers', 'pkg/glib/headers'}
lib('libgmodule-2.0.a', [[
	gmodule/(
		gmodule.c
	)
]])
fetch 'local'
