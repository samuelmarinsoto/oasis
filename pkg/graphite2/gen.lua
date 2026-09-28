rule('cxx', '$cc -std=c++11 -MD -MF $out.d $cflags -x c++ -c -o $out $in', {
	depfile='$out.d',
	deps='gcc',
})

cflags{
	'-I $srcdir/src',
	'-I $srcdir/include',
	'-D GRAPHITE2_STATIC',
}

pkg.hdrs = {
	copy('$outdir/include/graphite2', '$srcdir/include/graphite2', paths([[
		Font.h Log.h Segment.h Types.h
	]])),
	install=true,
}

local objs = {}
for src in iterpaths([=[src/(
	direct_machine.cpp
	CachedFace.cpp
	CmapCache.cpp
	Code.cpp
	Collider.cpp
	Decompressor.cpp
	Face.cpp
	FeatureMap.cpp
	FileFace.cpp
	Font.cpp
	GlyphCache.cpp
	GlyphFace.cpp
	Intervals.cpp
	Justifier.cpp
	NameTable.cpp
	Pass.cpp
	Position.cpp
	SegCache.cpp
	SegCacheEntry.cpp
	SegCacheStore.cpp
	Segment.cpp
	Silf.cpp
	Slot.cpp
	Sparse.cpp
	TtfUtil.cpp
	UtfCodec.cpp
	gr_char_info.cpp
	gr_face.cpp
	gr_features.cpp
	gr_font.cpp
	gr_logging.cpp
	gr_segment.cpp
	gr_slot.cpp
	json.cpp
)]=]) do
	objs[#objs + 1] = compile('cxx', src)
end
ar('libgraphite2.a', objs)

fetch 'curl'
