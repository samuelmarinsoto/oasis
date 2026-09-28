-- ANGLE GLSL/ES translator (the WebGL shader compiler).
-- No separate upstream release: the shared UXP checkout is the source of
-- truth, borrowed like pkg/acme-client borrows pkg/openbsd. Sources are the
-- translator subset selected by gfx/angle/moz.build (src/common,
-- src/compiler/preprocessor, src/compiler/translator,
-- src/third_party/compiler); libANGLE/EGL/renderers are not built.
set('srcdir', '$basedir/pkg/uxp/src/gfx/angle')

rule('cxx', '$cc -std=c++14 -MD -MF $out.d $cflags -x c++ -c -o $out $in', {
	depfile='$out.d',
	deps='gcc',
})

cflags{
	'-Wall',
	'-Wno-attributes',
	'-Wno-shadow',
	'-Wno-sign-compare',
	'-Wno-unknown-pragmas',
	'-Wno-unreachable-code',
	'-Wno-shadow-compatible-local',
	'-Wno-shadow-local',
	'-D ANGLE_ENABLE_GLSL=1',
	'-D ANGLE_ENABLE_ESSL=1',
	'-D ANGLE_ENABLE_HLSL=1',
	-- common/utilities.h drags in EGL/egl.h -> eglplatform.h, whose
	-- __unix__ branch pulls <X11/Xlib.h>; the ozone branch is the X11-free
	-- typedef-only path (R4: no X11 in the closure)
	'-D USE_OZONE',
	'-I $srcdir/include',
	'-I $srcdir/src',
	'-I $srcdir/src/common/third_party/numerics',
}

-- Install exactly the prefixes consumers include from (dom/canvas uses
-- "angle/ShaderLang.h", gfx/gl uses "angle/Platform.h"): mirror the real
-- dist/include/angle layout, not the raw include/ tree.
local hdrs = {}
local function hdr(out, src)
	out = '$outdir/include/'..out
	build('copy', out, '$srcdir/'..src)
	hdrs[#hdrs + 1] = out
end
hdr('angle/ShaderLang.h', 'include/GLSLANG/ShaderLang.h')
hdr('angle/ShaderVars.h', 'include/GLSLANG/ShaderVars.h')
hdr('angle/Platform.h', 'include/platform/Platform.h')
hdr('angle/KHR/khrplatform.h', 'include/KHR/khrplatform.h')
pkg.hdrs = hdrs
pkg.hdrs.install = true

pkg.deps = {
	'pkg/uxp/fetch',
}

ar('libangle.a', objects([[
	src/common/(
		angleutils.cpp debug.cpp Float16ToFloat32.cpp mathutil.cpp
		MemoryBuffer.cpp string_utils.cpp tls.cpp utilities.cpp
	)
	src/compiler/preprocessor/(
		DiagnosticsBase.cpp DirectiveHandlerBase.cpp DirectiveParser.cpp
		ExpressionParser.cpp Input.cpp Lexer.cpp Macro.cpp
		MacroExpander.cpp Preprocessor.cpp Token.cpp Tokenizer.cpp
	)
	src/compiler/translator/(
		AddDefaultReturnStatements.cpp ArrayReturnValueToOutParameter.cpp
		ASTMetadataHLSL.cpp blocklayout.cpp blocklayoutHLSL.cpp
		BuiltInFunctionEmulator.cpp BuiltInFunctionEmulatorGLSL.cpp
		BuiltInFunctionEmulatorHLSL.cpp Cache.cpp CallDAG.cpp CodeGen.cpp
		Compiler.cpp DeferGlobalInitializers.cpp
		depgraph/(
			DependencyGraph.cpp DependencyGraphBuilder.cpp
			DependencyGraphOutput.cpp DependencyGraphTraverse.cpp
		)
		Diagnostics.cpp DirectiveHandler.cpp EmulatePrecision.cpp
		ExpandIntegerPowExpressions.cpp ExtensionGLSL.cpp
		FlagStd140Structs.cpp ForLoopUnroll.cpp InfoSink.cpp
		Initialize.cpp InitializeDll.cpp InitializeParseContext.cpp
		InitializeVariables.cpp Intermediate.cpp IntermNode.cpp
		IntermNodePatternMatcher.cpp intermOut.cpp IntermTraverse.cpp
		LoopInfo.cpp Operator.cpp OutputESSL.cpp OutputGLSL.cpp
		OutputGLSLBase.cpp OutputHLSL.cpp ParseContext.cpp PoolAlloc.cpp
		PruneEmptyDeclarations.cpp RecordConstantPrecision.cpp
		RegenerateStructNames.cpp RemoveDynamicIndexing.cpp RemovePow.cpp
		RemoveSwitchFallThrough.cpp RewriteDoWhile.cpp
		RewriteElseBlocks.cpp RewriteTexelFetchOffset.cpp
		ScalarizeVecAndMatConstructorArgs.cpp SearchSymbol.cpp
		SeparateArrayInitialization.cpp SeparateDeclarations.cpp
		SeparateExpressionsReturningArrays.cpp ShaderLang.cpp
		ShaderVars.cpp SimplifyLoopConditions.cpp
		SplitSequenceOperator.cpp StructureHLSL.cpp SymbolTable.cpp
		TextureFunctionHLSL.cpp timing/(
			RestrictFragmentShaderTiming.cpp
			RestrictVertexShaderTiming.cpp
		)
		TranslatorESSL.cpp TranslatorGLSL.cpp TranslatorHLSL.cpp
		Types.cpp UnfoldShortCircuitAST.cpp UnfoldShortCircuitToIf.cpp
		UniformHLSL.cpp util.cpp UtilsHLSL.cpp
		ValidateGlobalInitializer.cpp ValidateLimitations.cpp
		ValidateMaxParameters.cpp ValidateOutputs.cpp ValidateSwitch.cpp
		VariableInfo.cpp VariablePacker.cpp VersionGLSL.cpp
		EmulateGLFragColorBroadcast.cpp glslang_lex.cpp glslang_tab.cpp
	)
	src/third_party/compiler/ArrayBoundsClamper.cpp
]]))

-- borrowed-source wiring (acme-client pattern): every $srcdir/... input
-- registered above is fed by pkg/uxp's fetch edge
build('phony', table.keys(pkg.inputs.fetch), 'pkg/uxp/fetch')
