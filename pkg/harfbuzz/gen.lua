rule('cxx', '$cc -std=c++11 -MD -MF $out.d $cflags -x c++ -c -o $out $in', {
	depfile='$out.d',
	deps='gcc',
})

cflags{
	'-I $srcdir/src',
	'-D HAVE_FREETYPE=1',
	'-D HAVE_GLIB=1',
	'-isystem $builddir/pkg/freetype/include',
	'-isystem $builddir/pkg/glib/include/glib-2.0',
}

pkg.hdrs = copy('$outdir/include', '$srcdir/src', {
	'hb.h', 'hb-ft.h', 'hb-glib.h', 'hb-aat.h', 'hb-aat-layout.h', 'hb-blob.h', 'hb-buffer.h',
	'hb-common.h', 'hb-deprecated.h', 'hb-draw.h', 'hb-face.h', 'hb-font.h',
	'hb-map.h', 'hb-ot.h', 'hb-ot-color.h', 'hb-ot-deprecated.h', 'hb-ot-font.h',
	'hb-ot-layout.h', 'hb-ot-math.h', 'hb-ot-meta.h', 'hb-ot-metrics.h',
	'hb-ot-name.h', 'hb-ot-shape.h', 'hb-ot-var.h', 'hb-paint.h', 'hb-set.h',
	'hb-shape.h', 'hb-shape-plan.h', 'hb-style.h', 'hb-unicode.h', 'hb-version.h',
})
pkg.deps = {'$gendir/headers', 'pkg/freetype/headers', 'pkg/glib/headers'}

local hbobjs = {}
for src in iterpaths([=[src/(
	hb-aat-layout.cc
	hb-aat-map.cc
	hb-blob.cc
	hb-buffer-serialize.cc
	hb-buffer-verify.cc
	hb-buffer.cc
	hb-common.cc
	hb-draw.cc
	hb-face-builder.cc
	hb-face.cc
	hb-fallback-shape.cc
	hb-font.cc
	hb-map.cc
	hb-number.cc
	hb-ot-cff1-table.cc
	hb-ot-cff2-table.cc
	hb-ot-color.cc
	hb-ot-face.cc
	hb-ot-font.cc
	hb-ot-layout.cc
	hb-ot-map.cc
	hb-ot-math.cc
	hb-ot-meta.cc
	hb-ot-metrics.cc
	hb-ot-name.cc
	hb-ot-shape-fallback.cc
	hb-ot-shape-normalize.cc
	hb-ot-shape.cc
	hb-ot-shaper-arabic.cc
	hb-ot-shaper-default.cc
	hb-ot-shaper-hangul.cc
	hb-ot-shaper-hebrew.cc
	hb-ot-shaper-indic-table.cc
	hb-ot-shaper-indic.cc
	hb-ot-shaper-khmer.cc
	hb-ot-shaper-myanmar.cc
	hb-ot-shaper-syllabic.cc
	hb-ot-shaper-thai.cc
	hb-ot-shaper-use.cc
	hb-ot-shaper-vowel-constraints.cc
	hb-ot-tag.cc
	hb-ot-var.cc
	hb-outline.cc
	hb-paint-extents.cc
	hb-paint.cc
	hb-set.cc
	hb-shape-plan.cc
	hb-shape.cc
	hb-shaper.cc
	hb-static.cc
	hb-style.cc
	hb-glib.cc
	hb-ft.cc
	hb-ucd.cc
	hb-unicode.cc
)]=]) do
	hbobjs[#hbobjs + 1] = compile('cxx', src)
end
ar('libharfbuzz.a', hbobjs)

fetch 'curl'
