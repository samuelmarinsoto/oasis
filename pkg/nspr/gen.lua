cflags{
	'-D XP_UNIX',
	'-D LINUX',
	'-D _GNU_SOURCE',
	'-D HAVE_FCNTL_FILE_LOCKING',
	'-D HAVE_POINTER_LOCALTIME_R',
	'-D _PR_PTHREADS',
	'-D FORCE_PR_LOG',
	'-I $outdir/include',
	'-I $srcdir/pr/include',
	'-I $srcdir/pr/include/private',
	'-I $srcdir/lib/libc/include',
	'-I $srcdir/lib/ds',
}

build('copy', '$outdir/include/prcpucfg.h', '$srcdir/pr/include/md/_linux.cfg')
build('printf', '$outdir/include/_pr_bld.h', {}, {args=[['#define _BUILD_STRING "1970-01-01 00:00:00"\n#define _BUILD_TIME 0\n#define _PRODUCTION "nspr"\n']]})

pkg.hdrs = {}
table.insert(pkg.hdrs, copy('$outdir/include', '$srcdir/pr/include', {
	'nspr.h', 'pratom.h', 'prbit.h', 'prclist.h', 'prcmon.h', 'prcountr.h',
	'prcvar.h', 'prdtoa.h', 'prenv.h', 'prerr.h', 'prerror.h', 'prinet.h',
	'prinit.h', 'prinrval.h', 'prio.h', 'pripcsem.h', 'prlink.h', 'prlock.h',
	'prlog.h', 'prlong.h', 'prmem.h', 'prmon.h', 'prmwait.h', 'prnetdb.h',
	'prolock.h', 'prpdce.h', 'prprf.h', 'prproces.h', 'prrng.h', 'prrwlock.h',
	'prshm.h', 'prshma.h', 'prsystem.h', 'prthread.h', 'prtime.h', 'prtpool.h',
	'prtrace.h', 'prtypes.h', 'prvrsion.h', 'prwin16.h'
}))
table.insert(pkg.hdrs, copy('$outdir/include/md', '$srcdir/pr/include/md', {
	'_pth.h', '_nspr_pthread.h',
}))
table.insert(pkg.hdrs, copy('$outdir/include/obsolete', '$srcdir/pr/include/obsolete', {
	'protypes.h',
}))
table.insert(pkg.hdrs, copy('$outdir/include', '$srcdir/lib/ds', {'plarena.h', 'plarenas.h', 'plhash.h'}))
table.insert(pkg.hdrs, copy('$outdir/include', '$srcdir/lib/libc/include', {'plbase64.h', 'plerror.h', 'plgetopt.h', 'plstr.h'}))
table.insert(pkg.hdrs, copy('$outdir/include/private', '$srcdir/pr/include/private', {'pprio.h', 'pprmwait.h', 'pprthred.h', 'primpl.h', 'prpriv.h'}))
table.insert(pkg.hdrs, '$outdir/include/prcpucfg.h')
table.insert(pkg.hdrs, '$outdir/include/_pr_bld.h')
pkg.deps = {
	'$gendir/headers',
	'$outdir/include/prcpucfg.h',
	'$outdir/include/_pr_bld.h',
}

lib('libnspr.a', [[
	pr/src/prvrsion.c
	pr/src/io/(
		prfdcach.c
		prmwait.c
		priometh.c
		pripv6.c
		prmapopt.c
		prlayer.c
		prlog.c
		prmmap.c
		prpolevt.c
		prprf.c
		prscanf.c
		prstdio.c
	)
	pr/src/linking/(prlink.c)
	pr/src/malloc/(
		prmalloc.c
		prmem.c
	)
	pr/src/md/(prosdep.c)
	pr/src/md/unix/(
		unix.c
		unix_errors.c
		uxproces.c
		uxrng.c
		uxshm.c
		uxwrap.c
		linux.c
		os_Linux_x86_64.s
	)
	pr/src/memory/(
		prseg.c
		prshm.c
		prshma.c
	)
	pr/src/misc/(
		pralarm.c
		pratom.c
		prcountr.c
		prdtoa.c
		prenv.c
		prerr.c
		prerror.c
		prerrortable.c
		prinit.c
		prinrval.c
		pripc.c
		prlog2.c
		prlong.c
		prnetdb.c
		praton.c
		prolock.c
		prrng.c
		prsystem.c
		prtime.c
		prthinfo.c
		prtpool.c
		prtrace.c
	)
	pr/src/pthreads/(
		ptio.c
		ptsynch.c
		ptthread.c
		ptmisc.c
	)
	pr/src/threads/(
		prcmon.c
		prrwlock.c
		prtpd.c
	)
]])

sub('plds.ninja', function()
	cflags{'-I $outdir/plds/include'}
	build('printf', '$outdir/plds/include/_pl_bld.h', {}, {args=[['#define _BUILD_STRING "1970-01-01 00:00:00"\n#define _BUILD_TIME 0\n#define _PRODUCTION "libplds4.a"\n']]})
	ar('libplds4.a', objects([[lib/ds/(
		plarena.c
		plhash.c
		plvrsion.c
	)]], {'$outdir/plds/include/_pl_bld.h'}))
end)

sub('plc.ninja', function()
	cflags{'-I $outdir/plc/include'}
	build('printf', '$outdir/plc/include/_pl_bld.h', {}, {args=[['#define _BUILD_STRING "1970-01-01 00:00:00"\n#define _BUILD_TIME 0\n#define _PRODUCTION "libplc4.a"\n']]})
	ar('libplc4.a', objects([[lib/libc/src/(
		plvrsion.c
		strlen.c
		strcpy.c
		strdup.c
		strcase.c
		strcat.c
		strcmp.c
		strchr.c
		strpbrk.c
		strstr.c
		strtok.c
		base64.c
		plerror.c
		plgetopt.c
	)]], {'$outdir/plc/include/_pl_bld.h'}))
end)

fetch 'local'
