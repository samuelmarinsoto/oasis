# libyuv

YUV/RGB pixel conversion (used by the media pipeline). Built from its own
upstream at the commit UXP's vendored copy is based on, with UXP's local
changes applied as the patch series in `patch/`. The vendored copy at
`pkg/uxp/src/media/libyuv` is the version reference and patch ground truth;
it is not the source we ship.

## Upstream and pin

Upstream is chromium's libyuv rolling repository
(https://chromium.googlesource.com/libyuv/libyuv, canonical; no release
tarballs). The pin is commit `88b050f337cc0ca2a51800fe7bf4737222c87344`
("MergeUV AVX512BW use assembly", 2023-02-20, LIBYUV_VERSION 1861),
fetched as a deterministic GitHub archive of the commit from the
project's well-known mirror (lemenkov/libyuv).

How the pin was identified:

- The vendored copy's `include/libyuv/version.h` says `LIBYUV_VERSION
  1861`; upstream history has exactly two commits carrying that version
  (88b050f3 and e66f4365, which only rolls DEPS).
- Content-hashing every vendored file against both candidates shows
  178/183 common files byte-identical to 88b050f3 (e66f4365 adds a
  differing DEPS).
- The five remaining differing files (`libyuv.gyp`, `libyuv.gypi`,
  `source/row_lsx.cc`, `source/row_lasx.cc`,
  `tools_libyuv/autoroller/roll_deps.py`) match no blob in the entire
  upstream history — they are genuine vendor (UXP/mozilla) changes, not
  a different snapshot. 88b050f3 is therefore the minimal-delta base.

The vendor delta is exactly: modifications to `libyuv.gyp`,
`libyuv.gypi`, `tools_libyuv/autoroller/roll_deps.py` and the LoongArch
LSX/LASX row files; additions of `moz.build` and `build/` helpers
(`dir_exists.py`, `find_sdk.py`, `find_sdk_uxp.py`); removal of
`.gitignore`. This is reproduced byte-for-byte by `patch/0001..0006`
(applies cleanly with `git apply`, verified against the vendored tree).

## Source list

From upstream `BUILD.gn` (`libyuv_internal`): the portable set plus the
gcc SIMD variants; `HAVE_JPEG` off (no libjpeg dependency); NEON, MSA,
LSX/LASX and MMX variants are other-arch or disabled and skipped. The
UXP `moz.build` non-unified list (convert, convert_argb, convert_from,
convert_from_argb, mjpeg_decoder, rotate_argb, row_common, scale,
scale_argb, scale_common, scale_uv) is a subset, consistent with the
pin. At this vintage there are no `*_sse2/_ssse3/_avx2` split files;
the x86 intrinsics in `*_gcc.cc` compile at baseline ISA, so no
per-file ISA flags are needed.
