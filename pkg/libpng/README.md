# libpng

Forked from upstream libpng 1.6.58 (tarball) with the third-party APNG
patch applied, matching the browser's bundled copy (UXP media/libpng,
"1.6.58+apng"). Gecko's PNG decoder (image/decoders/nsPNGDecoder.cpp)
uses the acTL/fcTL extension API, which stock 1.6.x does not provide;
without the patch, animated PNGs would silently render as a single
frame. APNG was never merged into libpng 1.6.x upstream; the delta is
carried in `patch/apng.patch` (extracted from UXP's media/libpng, see
the patch header for attribution).

`patch/0001-Add-C23-attribute-support.patch` is Michael Forney's C23
attribute fix (originally written against 1.6.43), ported forward to
1.6.58.

## config.h

Hand-written (configure output); version strings must match `ver`.

## pnglibconf.h

Generated at build time from `scripts/pnglibconf.dfa` + `pngusr.dfa`
via `scripts/options.awk`/`dfn.awk`; installed headers are `png.h`,
`pngconf.h`, and the generated `pnglibconf.h`.
