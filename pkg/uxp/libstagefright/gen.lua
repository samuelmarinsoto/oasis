-- stagefright subset (Android-derived MP4 support: foundation, liblog,
-- libutils, plus the mp4 extraction glue the fmp4 demuxer uses) built
-- straight from the shared UXP checkout, which is the source of truth:
-- the library has no separate upstream release. No fetch of its own; the
-- order-only dep below re-materializes pkg/uxp/src when needed.
set('srcdir', '$basedir/pkg/uxp/src/media/libstagefright')

cflags{
	'-I $basedir',
	-- per the vendored moz.build (Linux)
	'-D ANDROID_SMP=0',
	'-D LOG_NDEBUG=1',
	'-D HAVE_SYS_UIO_H=1',
	'-D FAKE_LOG_DEVICE=1',
	'-D _GLIBCXX_OS_DEFINES=1',
	-- the binding glue is an in-libxul consumer of XPCOM headers
	'-D MOZILLA_CLIENT',
	'-D MOZILLA_INTERNAL_API',
	'-D IMPL_LIBXUL',
	'-D MOZ_FMP4=1',
	'-D XP_UNIX=1',
	'-D XP_LINUX=1',
	'-D _LARGEFILE64_SOURCE',
	'-D _FILE_OFFSET_BITS=64',
	'-include $basedir/pkg/palemoon/gen/include/mozilla/Char16.h',
	'-include $basedir/pkg/palemoon/gen/include/mozilla-config.h',
	-- internal include closure: never installed (utils/... would collide)
	'-I $srcdir/binding/include',
	'-I $srcdir/frameworks/av/include',
	'-I $srcdir/frameworks/av/include/media/stagefright/foundation',
	'-I $srcdir/frameworks/av/media/libstagefright',
	'-I $srcdir/stubs/empty',
	'-I $srcdir/stubs/include',
	'-I $srcdir/stubs/include/media/stagefright/foundation',
	'-I $srcdir/system/core/include',
	-- in-libxul header closure (xpidl output and dist/include copies,
	-- committed under pkg/palemoon/gen; plain files, no build edge)
	'-isystem $basedir/pkg/palemoon/gen/include',
	'-isystem $builddir/pkg/nspr/include',
}

pkg.deps = {
	'pkg/uxp/fetch',
	'pkg/nspr/headers',
	-- generated/copied headers outside the pkg/nspr/headers phony
	'$builddir/pkg/nspr/include/prcpucfg.h',
	'$builddir/pkg/nspr/include/plhash.h',
	'$builddir/pkg/nspr/include/plarena.h',
	'$builddir/pkg/nspr/include/plarenas.h',
}

local stagefright = 'frameworks/av/media/libstagefright'
local objs = {
	compile('cc', stagefright..'/MetaData.cpp'),
	compile('cc', stagefright..'/foundation/hexdump.cpp'),
	compile('cc', 'system/core/libutils/RefBase.cpp'),
	compile('cc', 'system/core/libutils/String16.cpp'),
	compile('cc', 'system/core/libutils/String8.cpp'),
	compile('cc', 'system/core/libutils/VectorImpl.cpp'),
	cc('system/core/liblog/fake_log_device.c'),
	cc('system/core/libcutils/strdup16to8.c'),
	cc('system/core/liblog/logd_write.c'),
	cc('system/core/liblog/logprint.c'),
}

-- UNIFIED_SOURCES chunks, moz.build grouping: the binding glue only
-- compiles unified (later members lean on earlier members' includes).
build('awk', '$outdir/Unified_cpp_media_libstagefright0.cpp', paths([[
	$srcdir/binding/(Adts.cpp AnnexB.cpp BitReader.cpp Box.cpp BufferStream.cpp DecoderData.cpp H264.cpp Index.cpp MP4Metadata.cpp MoofParser.cpp ResourceStream.cpp SinfParser.cpp)
	$srcdir/]]..stagefright..[[/(DataSource.cpp ESDS.cpp MPEG4Extractor.cpp MediaBuffer.cpp)
]]), {expr='-f $dir/unify.awk'})
build('awk', '$outdir/Unified_cpp_media_libstagefright1.cpp', paths([[
	$srcdir/]]..stagefright..[[/(MediaDefs.cpp MediaSource.cpp SampleIterator.cpp SampleTable.cpp Utils.cpp)
	$srcdir/]]..stagefright..[[/foundation/(AAtomizer.cpp ABitReader.cpp ABuffer.cpp AString.cpp)
	$srcdir/system/core/libutils/(SharedBuffer.cpp Static.cpp Unicode.cpp)
]]), {expr='-f $dir/unify.awk'})

table.insert(objs, compile('cc', '$outdir/Unified_cpp_media_libstagefright0.cpp'))
table.insert(objs, compile('cc', '$outdir/Unified_cpp_media_libstagefright1.cpp'))

ar('libstagefright.a', objs)

-- what dom/media (and its mp4_demuxer consumers) includes, under the
-- prefix those includes use
pkg.hdrs = copy('$outdir/include', '$srcdir/binding/include', paths([[
	mp4_demuxer/(Adts.h AnnexB.h Atom.h AtomType.h BitReader.h BufferReader.h BufferStream.h ByteReader.h ByteWriter.h DecoderData.h H264.h Index.h Interval.h MoofParser.h MP4Metadata.h ResourceStream.h SinfParser.h Stream.h)
]]))
pkg.hdrs.install = true

-- every borrowed source is produced by the shared checkout's fetch stamp
build('phony', table.keys(pkg.inputs.fetch), 'pkg/uxp/fetch')
