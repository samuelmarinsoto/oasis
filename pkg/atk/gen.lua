cflags{
	'-D HAVE_CONFIG_H',
	'-I $dir',
	'-I $outdir/include/atk-1.0',
	'-I $builddir/pkg/glib/include/glib-2.0',
	'-D ATK_COMPILATION',
	'-D GETTEXT_PACKAGE="atk20"',
	'-include $dir/logdomain.h',
	'-D GLIB_DISABLE_DEPRECATION_WARNINGS',
}

build('copy', '$outdir/include/atk-1.0/atk/atk-enum-types.h', '$dir/atk-enum-types.h')
build('copy', '$outdir/include/atk-1.0/atk/atkversion.h', '$dir/atkversion.h')
build('copy', '$outdir/include/atk-1.0/atk/atkmarshal.h', '$dir/atkmarshal.h')

pkg.hdrs = {
	'$outdir/include/atk-1.0/atk/atk-enum-types.h',
	'$outdir/include/atk-1.0/atk/atkversion.h',
	'$outdir/include/atk-1.0/atk/atkmarshal.h',
	copy('$outdir/include/atk-1.0/atk', '$srcdir/atk', paths([[
		atk.h atkaction.h atkcomponent.h atkdocument.h atkeditabletext.h
		atkgobjectaccessible.h atkhyperlink.h atkhyperlinkimpl.h
		atkhypertext.h atkimage.h atkmisc.h atknoopobject.h
		atknoopobjectfactory.h atkobject.h atkobjectfactory.h atkplug.h
		atkrange.h atkregistry.h atkrelation.h atkrelationset.h atkrelationtype.h
		atkselection.h atksocket.h atkstate.h atkstateset.h
		atkstreamablecontent.h atktable.h atktablecell.h atktext.h
		atkutil.h atkvalue.h atkwindow.h
	]])),
	install=true,
}
pkg.deps = {
	'$gendir/headers',
	'pkg/glib/headers',
}

local objs = {}
for src in iterpaths([=[
	atk/(
		atkaction.c atkcomponent.c atkdocument.c atkeditabletext.c
		atkgobjectaccessible.c atkhyperlink.c atkhyperlinkimpl.c
		atkhypertext.c atkimage.c atkmisc.c atknoopobject.c
		atknoopobjectfactory.c atkobject.c atkobjectfactory.c atkplug.c
		atkprivate.c atkrange.c atkregistry.c atkrelation.c
		atkrelationset.c atkselection.c atksocket.c atkstate.c
		atkstateset.c atkstreamablecontent.c atktable.c atktablecell.c
		atktext.c atkutil.c atkvalue.c atkversion.c atkwindow.c
	)
]=]) do
	objs[#objs + 1] = compile('cc', src)
end
objs[#objs + 1] = compile('cc', '$dir/atk-enum-types.c', nil, {cflags='$cflags -I $outdir/include/atk-1.0/atk'})
objs[#objs + 1] = compile('cc', '$dir/atkmarshal.c', nil, {cflags='$cflags -I $outdir/include/atk-1.0/atk -I $dir'})
objs[#objs + 1] = '$builddir/pkg/glib/libglib-2.0.a'
objs[#objs + 1] = '$builddir/pkg/glib/libgobject-2.0.a'
ar('libatk-1.0.a', objs)

fetch 'curl'
