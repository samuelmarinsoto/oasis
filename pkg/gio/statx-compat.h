#ifndef STATX_COMPAT_H
#define STATX_COMPAT_H
#include <linux/stat.h>
#include <sys/syscall.h>
#include <unistd.h>
#ifndef SYS_statx
#define SYS_statx 332
#endif
static inline int statx(int dirfd, const char *pathname, int flags,
                        unsigned int mask, struct statx *buffer) {
  return (int)syscall(SYS_statx, dirfd, pathname, flags, mask, buffer);
}
#endif
