cflags{
	'-D HAVE_CONFIG_H',
	'-I $dir',
	'-I $outdir/include',
	'-I $srcdir/src',
	'-isystem $builddir/pkg/freetype/include',
	'-isystem $builddir/pkg/fontconfig/include',
	'-isystem $builddir/pkg/pixman/include',
	'-isystem $builddir/pkg/libpng/include',
	'-isystem $builddir/pkg/zlib/include',
	'-isystem $builddir/pkg/glib/include/glib-2.0',
}

pkg.hdrs = {
	copy('$outdir/include', '$srcdir/src', {'cairo.h', 'cairo-deprecated.h', 'cairo-ft.h', 'cairo-pdf.h', 'cairo-ps.h', 'cairo-tee.h', 'cairo-svg.h'}),
	copy('$outdir/include', '$srcdir/util/cairo-gobject', {'cairo-gobject.h'}),
	copy('$outdir/include', '$srcdir', {'cairo-version.h'}),
	copy('$outdir/include', '$dir', {'cairo-features.h'}),
	install=true,
}
pkg.deps = {
	'$gendir/headers',
	'pkg/freetype/headers',
	'pkg/fontconfig/headers',
	'pkg/pixman/headers',
	'pkg/libpng/headers',
	'pkg/zlib/headers',
	'pkg/glib/headers',
}

lib('libcairo.a', [[src/(
		cairo-analysis-surface.c
		cairo-arc.c
		cairo-array.c
		cairo-atomic.c
		cairo-base64-stream.c
		cairo-base85-stream.c
		cairo-bentley-ottmann-rectangular.c
		cairo-bentley-ottmann-rectilinear.c
		cairo-bentley-ottmann.c
		cairo-botor-scan-converter.c
		cairo-boxes-intersect.c
		cairo-boxes.c
		cairo-cache.c
		cairo-clip-boxes.c
		cairo-clip-polygon.c
		cairo-clip-region.c
		cairo-clip-surface.c
		cairo-clip-tor-scan-converter.c
		cairo-clip.c
		cairo-color.c
		cairo-composite-rectangles.c
		cairo-compositor.c
		cairo-contour.c
		cairo-damage.c
		cairo-debug.c
		cairo-default-context.c
		cairo-device.c
		cairo-error.c
		cairo-fallback-compositor.c
		cairo-fixed.c
		cairo-font-face-twin-data.c
		cairo-font-face-twin.c
		cairo-font-face.c
		cairo-font-options.c
		cairo-freed-pool.c
		cairo-freelist.c
		cairo-gstate.c
		cairo-hash.c
		cairo-hull.c
		cairo-image-compositor.c
		cairo-image-info.c
		cairo-image-source.c
		cairo-image-surface.c
		cairo-line.c
		cairo-lzw.c
		cairo-mask-compositor.c
		cairo-matrix.c
		cairo-mempool.c
		cairo-mesh-pattern-rasterizer.c
		cairo-misc.c
		cairo-mono-scan-converter.c
		cairo-mutex.c
		cairo-no-compositor.c
		cairo-observer.c
		cairo-output-stream.c
		cairo-paginated-surface.c
		cairo-path-bounds.c
		cairo-path-fill.c
		cairo-path-fixed.c
		cairo-path-in-fill.c
		cairo-path-stroke-boxes.c
		cairo-path-stroke-polygon.c
		cairo-path-stroke-traps.c
		cairo-path-stroke-tristrip.c
		cairo-path-stroke.c
		cairo-path.c
		cairo-pattern.c
		cairo-pen.c
		cairo-polygon-intersect.c
		cairo-polygon-reduce.c
		cairo-polygon.c
		cairo-raster-source-pattern.c
		cairo-recording-surface.c
		cairo-rectangle.c
		cairo-rectangular-scan-converter.c
		cairo-region.c
		cairo-rtree.c
		cairo-scaled-font.c
		cairo-shape-mask-compositor.c
		cairo-slope.c
		cairo-spans-compositor.c
		cairo-spans.c
		cairo-spline.c
		cairo-stroke-dash.c
		cairo-stroke-style.c
		cairo-surface-clipper.c
		cairo-surface-fallback.c
		cairo-surface-observer.c
		cairo-surface-offset.c
		cairo-surface-snapshot.c
		cairo-surface-subsurface.c
		cairo-surface-wrapper.c
		cairo-surface.c
		cairo-tee-surface.c
		cairo-time.c
		cairo-tor-scan-converter.c
		cairo-tor22-scan-converter.c
		cairo-toy-font-face.c
		cairo-traps-compositor.c
		cairo-traps.c
		cairo-tristrip.c
		cairo-unicode.c
		cairo-user-font.c
		cairo-version.c
		cairo-wideint.c
		cairo.c
	)
	src/cairo-ft-font.c
	src/cairo-png.c
	src/cairo-pdf-surface.c
	src/cairo-pdf-interchange.c
	src/cairo-pdf-operators.c
	src/cairo-pdf-shading.c
	src/cairo-ps-surface.c
	src/cairo-svg-surface.c
	src/cairo-deflate-stream.c
	src/cairo-type1-subset.c
	src/cairo-type1-fallback.c
	src/cairo-type3-glyph-surface.c
	src/cairo-truetype-subset.c
	src/cairo-cff-subset.c
	src/cairo-scaled-font-subsets.c
	src/cairo-tag-attributes.c
	src/cairo-tag-stack.c
	src/cairo-type1-glyph-names.c
	util/cairo-gobject/cairo-gobject-structs.c
	util/cairo-gobject/cairo-gobject-enums.c]],
	{
		'$gendir/headers',
		'pkg/freetype/headers',
		'pkg/fontconfig/headers',
		'pkg/pixman/headers',
		'pkg/libpng/headers',
		'$builddir/pkg/freetype/libfreetype.a',
		'$builddir/pkg/fontconfig/libfontconfig.a',
		'$builddir/pkg/pixman/libpixman.a',
		'$builddir/pkg/libpng/libpng.a',
		'$builddir/pkg/zlib/libz.a',
	})

fetch 'curl'
