cflags{
	'-D HAVE_CONFIG_H',
	'-I $dir',
	'-I $srcdir/src',
	'-I $outdir/include',
}

pkg.hdrs = {
	copy('$outdir/include/epoxy', '$srcdir/include/epoxy', {'common.h', 'gl.h', 'egl.h'}),
	copy('$outdir/include/epoxy', '$dir', {'gl_generated.h', 'egl_generated.h'}),
	copy('$outdir/include/EGL', '$dir/eglcompat/EGL', {'eglplatform.h'}),
	install=true,
}
pkg.deps = {'$gendir/headers'}

local objs = {}
objs[#objs + 1] = compile('cc', 'src/dispatch_common.c')
objs[#objs + 1] = compile('cc', 'src/dispatch_egl.c')
objs[#objs + 1] = compile('cc', '$dir/gl_generated_dispatch.c')
objs[#objs + 1] = compile('cc', '$dir/egl_generated_dispatch.c')
ar('libepoxy.a', objs)

fetch 'curl'
