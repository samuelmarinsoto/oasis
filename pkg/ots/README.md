# ots

OpenType Sanitizer, as a static library. Part of the Pale Moon port: UXP
vendors ots under `gfx/ots` and `pkg/palemoon` will link this package
instead of compiling the vendored copy inline.

## Source policy

- Upstream: https://github.com/khaledhosny/ots (named in the vendored
  tree's `README.mozilla`).
- Pin: tag `v8.0.0`, commit `8bba749d9d5401726a7d7609ab914fdb5e92bfbe`
  (the revision `README.mozilla` declares; confirmed via the GitHub API
  that the tag points at that commit).
- Fetched as the codeload archive of that commit; the delta between the
  pristine tarball and UXP's vendored copy is carried as the patch
  series under `patch/`.

## Patch series

Patches 0001-0006 reproduce UXP's vendored delta, split by topic:

- `0001` carries UXP's `ots-visibility.patch` unchanged (OTS_API
  markup; empty for static builds, kept so the installed header is
  byte-identical to UXP's).
- `0002`-`0005` are the fuzz-driven fixes UXP carries on top of 8.0.0
  (composite glyph point counts, cmap format 12 off-by-one, STAT
  designAxisSize, Buffer bounds checks); upstream commit references are
  in the patch descriptions where identified.
- `0006` is a format-security fix to `Table::Message`.
- `0007` is ours (not UXP): WOFF2 support is gated behind `OTS_WOFF2`
  because upstream's woff2/brotli live in git submodules that are not
  part of the release tarball and are packaged separately here.

Deliberately not carried from the UXP delta:

- `ots-lz4.patch` routes graphite table decompression through
  `mozilla::Compression`, which does not exist outside mfbt. This build
  keeps upstream's code and compiles graphite support out (see below).
- `src/moz.build`: build metadata replaced by `gen.lua`.

## Configuration vs UXP's build

- Graphite table sanitization is OFF: upstream gates it on the
  `third_party/lz4` submodule, which is absent from the tarball and not
  packaged separately. Graphite tables therefore pass through
  unsanitized. To enable: define `OTS_GRAPHITE`, add
  `src/{feat,glat,gloc,sile,silf,sill}.cc` to the source list and
  provide an lz4 (the UXP alternative needs mfbt).
- WOFF2 is OFF until `pkg/brotli` and `pkg/woff2` land; then build with
  `-D OTS_WOFF2`, add their include dirs and `headers` targets, and
  link their archives in consumers. WOFF2 fonts are rejected cleanly
  meanwhile.
- No `config.h`: nothing in the sources reads the PACKAGE/VERSION
  macros upstream puts there, so `HAVE_CONFIG_H` is not defined.
- `OTS_VARIATIONS` (set by UXP's moz.build) is vestigial in 8.0.0:
  variation tables are unconditional there.

## Consumers

`gfx/thebes/gfxUserFontSet.cpp` includes `"opentype-sanitiser.h"` and
`"ots-memory-stream.h"` bare, so both are installed at the include root
(`pkg.hdrs` with `install = true`; consume as `pkg/ots/headers`).
Archive: `out/pkg/ots/libots.a`.
