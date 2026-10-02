rule('cxx', '$cc -std=c++17 -MD -MF $out.d $cflags -x c++ -c -o $out $in', {
	depfile='$out.d',
	deps='gcc',
})

cflags{
	'-D U_STATIC_IMPLEMENTATION=1',
	'-D U_COMMON_IMPLEMENTATION=1',
	'-D U_I18N_IMPLEMENTATION=1',
	'-D U_ENABLE_DYLOAD=0',
	'-D U_CHECK_DYLOAD=0',
	'-D U_NO_DEFAULT_INCLUDE_UTF_HEADERS=1',
	'-I $dir',
	'-I $srcdir/common',
	'-I $srcdir/stubdata',
	'-I $srcdir/i18n',
}

local commonobjs = {}
for src in iterlines('common.txt') do
	commonobjs[#commonobjs + 1] = compile('cxx', src)
end
-- stubdata: forces ICU to load the real data file at runtime
-- (share/icu/78.2/icudt78l.dat, installed below)
ar('libicudata.a', {compile('cxx', 'stubdata/stubdata.cpp')})

-- ship the data file: upstream icu4c ships its own prebuilt icudt78l.dat
-- inside the source tree (data/in/), fetched as part of the normal source fetch
file('share/icu/78.2/icudt78l.dat', '444', '$srcdir/data/in/icudt78l.dat')
ar('libicuuc.a', commonobjs)

local i18nobjs = {}
for src in iterlines('i18n.txt') do
	i18nobjs[#i18nobjs + 1] = compile('cxx', src)
end
ar('libicui18n.a', i18nobjs)

fetch 'local'
