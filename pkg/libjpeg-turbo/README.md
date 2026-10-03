# libjpeg-turbo

# `jconfig.h` and `jconfigint.h`
Generated with

	cmake -DENABLE_SHARED=0 -DWITH_SIMD=0 -DWITH_JPEG8=1 ..

# SIMD
nasm-assembled x86_64 objects per `src/simd/CMakeLists.txt`; runtime CPUID
dispatch lives in `simd/x86_64/jsimd.c` (no jconfig knob — mozilla builds
the vendored copy the same way).
