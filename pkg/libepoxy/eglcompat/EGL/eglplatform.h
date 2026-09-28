#ifndef __eglplatform_h_
#define __eglplatform_h_ 1

#include <stdint.h>

/* Khronos platform types (subset of khrplatform.h) */
typedef int32_t khronos_int32_t;
typedef uint32_t khronos_uint32_t;
typedef int64_t khronos_int64_t;
typedef uint64_t khronos_uint64_t;
typedef uintptr_t khronos_uintptr_t;

#if defined(_WIN32) || defined(__VC32__)
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN 1
#endif
typedef HDC     EGLNativeDisplayType;
typedef HBITMAP EGLNativePixmapType;
typedef HWND    EGLNativeWindowType;

#elif defined(__APPLE__) || defined(__APPLE_CC__)
typedef void *EGLNativeDisplayType;
typedef void *EGLNativePixmapType;
typedef void *EGLNativeWindowType;

#elif defined(WL_EGL_PLATFORM)
struct wl_display;
struct wl_egl_window;
struct wl_egl_pixmap;
typedef struct wl_display    *EGLNativeDisplayType;
typedef struct wl_egl_pixmap *EGLNativePixmapType;
typedef struct wl_egl_window *EGLNativeWindowType;

#elif defined(__GBM__)
typedef struct gbm_device  *EGLNativeDisplayType;
typedef struct gbm_bo      *EGLNativePixmapType;
typedef struct gbm_surface *EGLNativeWindowType;

#elif defined(__unix__) || defined(EGL_NO_X11)
/* No X11 stack in this build (R4); X native types never used at runtime. */
typedef void             *EGLNativeDisplayType;
typedef khronos_uintptr_t EGLNativePixmapType;
typedef khronos_uintptr_t EGLNativeWindowType;

#else
#error "Platform not recognized"
#endif

typedef khronos_int32_t EGLNativeFileDescriptor;

typedef khronos_int32_t EGLint;

#ifndef APIENTRY
#define APIENTRY
#endif
#ifndef APIENTRYP
#define APIENTRYP APIENTRY *
#endif

#endif /* __eglplatform_h_ */
