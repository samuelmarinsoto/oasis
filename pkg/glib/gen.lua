cflags{
	'-D HAVE_CONFIG_H',
	'-D SIZEOF_CHAR=1',
	'-D SIZEOF_SHORT=2',
	'-D SIZEOF_INT=4',
	'-D SIZEOF_LONG=8',
	'-D SIZEOF_LONG_LONG=8',
	'-D SIZEOF_VOID_P=8',
	'-D SIZEOF_SIZE_T=8',
	'-include $outdir/include/glib-2.0/glib/glib.h',
	'-I $dir',
	'-I $srcdir/glib',
	'-I $srcdir/glib/pcre',
	'-isystem $builddir/pkg/libffi/include',
	'-I $outdir/include/glib-2.0',
	'-I $outdir/include/glib-2.0/gobject',
	'-include $dir/logdomain.h',
	'-D GLIB_COMPILATION',
	'-D GOBJECT_COMPILATION',
	'-D __GLIB_GOBJECT_H_INSIDE__',
	'-D LIBDIR=\\"/usr/lib\\"',
	'-D SUPPORT_UTF',
	'-D SUPPORT_UCP',
	'-D NO_RECURSE',
	'-D LINK_SIZE=2',
	'-D PCRE_STATIC',
	'-D POSIX_MALLOC_THRESHOLD=10',
	'-D MATCH_LIMIT=10000000',
	'-D MATCH_LIMIT_RECURSION=10000',
	'-D NEWLINE=10',
	'-D BSR_ANYCRLF',
	'-D SUPPORT_PCRE8',
	'-D MAX_NAME_SIZE=32',
	'-D MAX_NAME_COUNT=10000',
	'-D GLIB_DISABLE_DEPRECATION_WARNINGS',
	'-Wno-error=int-conversion',
	'-Wno-error=incompatible-pointer-types',
	'-Wno-error=implicit-function-declaration',
}

build('copy', '$outdir/include/glib-2.0/glibconfig.h', '$dir/glibconfig.h')

pkg.hdrs = {
	copy('$outdir/include/glib-2.0/gio-internal', '$srcdir/gio', {'gioenums.h'}),
	copy('$outdir/include/glib-2.0/gobject-internal/gobject', '$srcdir/gobject', {'gobjectnotifyqueue.c'}),
	copy('$outdir/include/glib-2.0/glib', '$srcdir/glib', paths([[
		galloca.h garray.h gasyncqueue.h gasyncqueueprivate.h
		gatomic.h gbacktrace.h gbase64.h gbitlock.h
		gbookmarkfile.h gbsearcharray.h gbytes.h gcharset.h
		gcharsetprivate.h gchecksum.h gconstructor.h gconvert.h
		gdataset.h gdatasetprivate.h gdate.h gdatetime.h
		gdir.h genviron.h gerror.h gfileutils.h
		ggettext.h ghash.h ghmac.h ghook.h
		ghostutils.h gi18n-lib.h gi18n.h giochannel.h
		gkeyfile.h glib-autocleanups.h glib-init.h glib-object.h
		glib-private.h glib-unix.h glib.h glib_trace.h
		glibintl.h glist.h gmacros.h gmain-internal.h
		gmain.h gmappedfile.h gmarkup.h gmem.h
		gmessages.h gmirroringtable.h gnode.h goption.h
		gpattern.h gpoll.h gprimes.h gprintf.h
		gprintfint.h gqsort.h gquark.h gqueue.h
		grand.h grcbox.h grcboxprivate.h grefcount.h
		grefstring.h gregex.h gscanner.h gscripttable.h
		gsequence.h gshell.h gslice.h gslist.h
		gspawn-private.h gspawn.h gstdio.h gstdioprivate.h
		gstrfuncs.h gstrfuncsprivate.h gstring.h gstringchunk.h
		gtestutils.h gthread.h gthreadpool.h gthreadprivate.h
		gtimer.h gtimezone.h gtrace-private.h gtranslit-data.h
		gtrashstack.h gtree.h gtypes.h gunibreak.h
		gunichartables.h gunicode.h gunicodeprivate.h gunicomp.h
		gunidecomp.h guri.h guriprivate.h gutils.h
		gutilsprivate.h guuid.h gvalgrind.h gvariant-core.h
		gvariant-internal.h gvariant-serialiser.h gvariant.h gvarianttype.h
		gvarianttypeinfo.h gversion.h gversionmacros.h gwakeup.h
		gwin32.h valgrind.h

	]])),
	copy('$outdir/include/glib-2.0/gobject', '$srcdir/gobject', paths([[
		gatomicarray.h gbinding.h gboxed.h gclosure.h
		genums.h glib-types.h gmarshal.h gobject-autocleanups.h
		gobject.h gobject_trace.h gparam.h gparamspecs.h
		gsignal.h gsourceclosure.h gtype-private.h gtype.h
		gtypemodule.h gtypeplugin.h gvalue.h gvaluearray.h
		gvaluecollector.h gvaluetypes.h

	]])),
	copy('$outdir/include/glib-2.0/glib/deprecated', '$srcdir/glib/deprecated', paths([[
		gallocator.h gcache.h gcompletion.h gmain.h
		grel.h gthread.h
	]])),
	copy('$outdir/include/glib-2.0/gobject', '$dir', {'glib-enumtypes.h'}),
	copy('$outdir/include/glib-2.0', '$srcdir/glib', {'glib.h', 'glib-object.h'}),
	copy('$outdir/include/glib-2.0', '$srcdir/gobject', {'gobject.h'}),
	install=true,
}
pkg.deps = {'$gendir/headers', '$outdir/include/glib-2.0/glibconfig.h', 'pkg/libffi/headers'}

local glibsrcs = [=[
	glib/(
		docs.c garcbox.c garray.c gasyncqueue.c gatomic.c gbacktrace.c
		gbase64.c gbitlock.c gbookmarkfile.c gbytes.c gcharset.c
		gchecksum.c gconvert.c gdataset.c gdate.c gdatetime.c gdir.c
		genviron.c gerror.c gfileutils.c ggettext.c ghash.c ghmac.c
		ghook.c ghostutils.c giochannel.c giounix.c gkeyfile.c
		glib-init.c glib-private.c glib-unix.c glist.c gmain.c
		gmappedfile.c gmarkup.c gmem.c gmessages.c gnode.c goption.c
		gpattern.c gpoll.c gprimes.c gprintf.c gqsort.c gquark.c gqueue.c
		grand.c grcbox.c grefcount.c grefstring.c gregex.c gscanner.c
		gsequence.c gshell.c gslice.c gslist.c gspawn.c gstdio.c
		gstdio-private.c gstrfuncs.c gstring.c gstringchunk.c gtestutils.c gthread.c
		gthread-posix.c gthreadpool.c gtimer.c gtimezone.c gtrace.c
		gtranslit.c gtrashstack.c gtree.c gunibreak.c gunicollate.c
		gunidecomp.c guniprop.c guri.c gutf8.c gutils.c guuid.c
		gvariant-core.c gvariant-parser.c gvariant-serialiser.c
		gvariant.c gvarianttype.c gvarianttypeinfo.c gversion.c
		gwakeup.c
		gnulib/(printf.c vasnprintf.c asnprintf.c printf-args.c printf-parse.c)
		pcre/(
			pcre_byte_order.c pcre_chartables.c pcre_compile.c
			pcre_config.c pcre_dfa_exec.c pcre_exec.c pcre_fullinfo.c
			pcre_get.c pcre_globals.c pcre_jit_compile.c
			pcre_newline.c pcre_ord2utf8.c pcre_string_utils.c
			pcre_study.c pcre_tables.c pcre_valid_utf8.c
			pcre_version.c pcre_xclass.c
		)
	)
	glib/libcharset/localcharset.c
	$dir/glib-enumtypes.c
]=]

local gobjs = {}
for src in iterpaths([=[
	gobject/(
		gatomicarray.c gbinding.c gboxed.c gclosure.c genums.c
		gmarshal.c gobject.c gobjectnotifyqueue.c gparam.c
		gparamspecs.c gsignal.c gsourceclosure.c gtype.c gtypemodule.c
		gtypeplugin.c gvalue.c gvaluearray.c gvaluetransform.c
		gvaluetypes.c
	)
]=]) do
	gobjs[#gobjs + 1] = compile('cc', src)
end
gobjs[#gobjs + 1] = '$builddir/pkg/libffi/libffi.a'
ar('libglib-2.0.a', objects(glibsrcs, {'$gendir/headers'}))
ar('libgobject-2.0.a', gobjs)

fetch 'curl'
