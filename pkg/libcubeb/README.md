# libcubeb (ALSA-only static library)

Audio callback library for the Pale Moon port. ALSA backend only (R3:
no PulseAudio, no JACK, no sndio, no dbus); compiled directly into
`liblibcubeb.a` for `pkg/palemoon` to link.

## Source and pin identification

Upstream is mozilla/cubeb, then named kinetiknz/cubeb. The pin was
identified from the vendored copy in UXP
(`pkg/uxp/src/media/libcubeb`): its `README_MOZILLA` names the
repository (`git://github.com/kinetiknz/cubeb.git`) and the exact
commit (`f8467510a8b36793b1b8b7e85461e2e189eb7015`), and `update.sh`
lists the local patch series applied on top of it. The pin was then
verified by simulation: copying the upstream snapshot through
update.sh's mappings and applying the patch series reproduced the
vendored tree byte-for-byte for every file the ALSA-only build
compiles (`src/cubeb.c`, `src/cubeb_alsa.c`, `src/cubeb_panner.cpp`
and their include closure).

## The patch series

`patch/` carries UXP's local changes, relevelled to apply with
`git apply -p1` against the pristine upstream tarball layout
(update.sh's own invocation was inconsistent: some patches carry
`media/libcubeb/` prefixes under the wrong strip level, and
`uplift-wasapi-part-to-beta.patch` does not apply at the `-p1`
update.sh records). Numbers preserve update.sh's application order.

Patches 0001-0006 and 0008-0010 are mozilla-central's own patches
(HG headers kept as descriptions). Patches 0011-0013 carry the three
undocumented vendored edits that touch compiled files:

- 0011: register the sun audio backend (not compiled here; USE_SUN
  stays undefined, `cubeb_sun.c` is a mozilla-local file we do not
  carry)
- 0012: null dereference before abort() in cubeb_crash()
- 0013: ALSA recovery failure reports CUBEB_STATE_ERROR instead of
  asserting

`0007-fix-crashes.patch` is NOT carried: it does not apply on the
pinned base in either order relative to 0006 (its
`src/cubeb_wasapi.cpp:1199` context matches neither the pre- nor
post-uplift tree; mozilla-central drift), and it touches only
`cubeb_wasapi.cpp`, a backend excluded from this build (R3). The
same is true of the vendored-only edits to `cubeb_opensl.c`,
`cubeb_sndio.c` and `cubeb_audiounit.cpp` that update.sh never
described: none affect an ALSA build.

## Files we carry that upstream lacks

`cubeb_export.h` (this directory): upstream generates it with CMake;
mozilla vendors a hand-written version defining `CUBEB_EXPORT` to
empty for the Gecko build. We vendor mozilla's file and install it
alongside `cubeb.h` as `include/cubeb/cubeb_export.h`.

## Notes

- Sources compiled: `src/cubeb.c`, `src/cubeb_alsa.c`,
  `src/cubeb_panner.cpp`, per this pin's `src/moz.build` with
  `MOZ_ALSA`/`USE_ALSA` (defines: `CUBEB_GECKO_BUILD`, `USE_ALSA`).
  No resampler: `cubeb_resampler.cpp` is only built for the
  pulse/jack/darwin/winnt backends, so there is no libspeex
  dependency at this pin (the ground-truth build linked exactly
  cubeb.o, cubeb_alsa.o and cubeb_panner.o).
- `strings` on the archive finds the word "pulse" once, from
  `cubeb_alsa.c`'s probe of the ALSA config for the ALSA-PulseAudio
  bridge plugin (`strcmp(string, "pulse")`); no PulseAudio code or
  symbols are linked.
