-- UXP platform sources consumed by pkg/palemoon (app.mozbuild expects
-- them rooted at /platform/).
--
-- The umbrella also claims shared-tree headers that sub-packages compile
-- against (mfbt): exactly one package may register a file as a fetch
-- output, so the claim lives here, owned by the fetch that materializes
-- them. Sub-packages must NOT register shared files themselves.
for _, h in ipairs({
	'Assertions.h',
	'Attributes.h',
	'Compiler.h',
	'DebugOnly.h',
	'EndianUtils.h',
	'Likely.h',
	'MacroArgs.h',
	'Move.h',
	'StaticAnalysisFunctions.h',
	'TypeTraits.h',
	'Types.h',
}) do
	pkg.inputs.fetch['$srcdir/mfbt/' .. h] = true
end

subgen 'fdlibm'
subgen 'qcms'
subgen 'angle'
subgen 'libmkv'
subgen 'psshparser'
subgen 'libstagefright'
subgen 'libjpeg'
subgen 'protobuf'

fetch 'git'
