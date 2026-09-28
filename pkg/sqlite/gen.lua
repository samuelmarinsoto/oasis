cflags{
	'-D SQLITE_THREADSAFE=1',
	'-D SQLITE_OMIT_LOAD_EXTENSION',
	'-D SQLITE_ENABLE_FTS3',
	'-D SQLITE_ENABLE_FTS3_PARENTHESIS',
	'-D SQLITE_ENABLE_DESERIALIZE',
}

pkg.hdrs = copy('$outdir/include', '$srcdir', {
	'sqlite3.h', 'sqlite3ext.h',
})
pkg.deps = {'$gendir/headers'}

lib('libsqlite3.a', 'sqlite3.c')

sub('shell.ninja', function()
	cflags{'-D SQLITE_HAVE_READLINE=0'}
	exe('sqlite3', {'shell.c', '$builddir/pkg/sqlite/libsqlite3.a'})
end)

fetch 'curl'
