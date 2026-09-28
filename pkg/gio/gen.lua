cflags{
	'-D HAVE_CONFIG_H',
	'-I $dir',
	'-I $builddir/pkg/glib/include/glib-2.0',
	'-I $builddir/pkg/glib/include/glib-2.0/glib',
	'-I $builddir/pkg/glib/src',
	'-I $builddir/pkg/glib/src/glib',
	'-I $outdir/include/glib-2.0',
	'-I $outdir/include/glib-2.0/gio',
	'-I $srcdir',
	'-I $srcdir/gio',
	'-D GIO_COMPILATION',
	'-include $dir/logdomain.h',
	'-D GLIB_DISABLE_DEPRECATION_WARNINGS',
	'-Wno-error=int-conversion',
	'-Wno-error=incompatible-pointer-types',
	'-isystem $builddir/pkg/zlib/include',
	'-I $builddir/pkg/gmodule/include/glib-2.0',
	'-include $dir/config.h',
	'-D _GNU_SOURCE',
}

local hdrnames = {}
for line in iterlines('hdrs.txt') do
	for h in line:gmatch('%S+') do
		hdrnames[#hdrnames + 1] = h
	end
end
local srcnames = {}
for line in iterlines('srcs.txt') do
	for s in line:gmatch('%S+') do
		srcnames[#srcnames + 1] = 'gio/' .. s
	end
end
local xdg = {}
for line in iterlines('xdgsrcs.txt') do
	for s in line:gmatch('%S+') do
		xdg[#xdg + 1] = 'gio/xdgmime/' .. s
	end
end
local ino = {}
for line in iterlines('inosrcs.txt') do
	for s in line:gmatch('%S+') do
		ino[#ino + 1] = 'gio/inotify/' .. s
	end
end
local gvdb = {}
for line in iterlines('gvdbsrcs.txt') do
	for s in line:gmatch('%S+') do
		gvdb[#gvdb + 1] = 'gio/gvdb/' .. s
	end
end

build('copy', '$outdir/include/glib-2.0/gio/gio-enum-types.h', '$dir/gio-enum-types.h')
build('copy', '$outdir/include/glib-2.0/gio/gnetworking.h', '$dir/gnetworking.h')
build('copy', '$outdir/include/glib-2.0/gio/gioenumtypes.h', '$dir/gio-enum-types.h')

pkg.hdrs = {
	copy('$outdir/include/glib-2.0/gio', '$srcdir/gio', hdrnames),
	install=true,
}
pkg.deps = {
	'$gendir/headers',
	'$outdir/include/glib-2.0/gio/gio-enum-types.h',
	'pkg/glib/headers',
	'pkg/gmodule/headers',
}

local gobjs = {}
for _, s in ipairs(xdg) do
	gobjs[#gobjs + 1] = compile('cc', s, nil, {cflags='$cflags -DXDG_PREFIX=_gio_xdg'})
end
for _, s in ipairs(ino) do
	gobjs[#gobjs + 1] = compile('cc', s)
end
for _, s in ipairs(gvdb) do
	gobjs[#gobjs + 1] = compile('cc', s)
end
for _, s in ipairs(srcnames) do
	gobjs[#gobjs + 1] = compile('cc', s)
end
gobjs[#gobjs + 1] = compile('cc', '$dir/gio-enum-types.c')
gobjs[#gobjs + 1] = compile('cc', '$dir/xdp-dbus.c')
gobjs[#gobjs + 1] = '$builddir/pkg/glib/libglib-2.0.a'
gobjs[#gobjs + 1] = '$builddir/pkg/glib/libgobject-2.0.a'
gobjs[#gobjs + 1] = '$builddir/pkg/libffi/libffi.a'
gobjs[#gobjs + 1] = '$builddir/pkg/zlib/libz.a'
ar('libgio-2.0.a', gobjs)

fetch 'local'
