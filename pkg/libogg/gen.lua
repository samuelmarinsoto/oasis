cflags{
	'-I $srcdir/include',
	'-I $outdir/include',
}

build('sed', '$outdir/include/ogg/config_types.h', '$srcdir/include/ogg/config_types.h.in', {
	expr={
		'-e s,@INCLUDE_INTTYPES_H@,1,',
		'-e s,@INCLUDE_STDINT_H@,1,',
		'-e s,@INCLUDE_SYS_TYPES_H@,1,',
		'-e s,@SIZE16@,int16_t,',
		'-e s,@USIZE16@,uint16_t,',
		'-e s,@SIZE32@,int32_t,',
		'-e s,@USIZE32@,uint32_t,',
		'-e s,@SIZE64@,int64_t,',
		'-e s,@USIZE64@,uint64_t,',
	},
})
pkg.hdrs = {
	copy('$outdir/include/ogg', '$srcdir/include/ogg', paths([[
		ogg.h os_types.h
	]])),
	'$outdir/include/ogg/config_types.h',
	install=true,
}
pkg.deps = {
	'$gendir/headers',
}

ar('libogg.a', {
	compile('cc', 'src/bitwise.c'),
	compile('cc', 'src/framing.c'),
})

fetch 'curl'
