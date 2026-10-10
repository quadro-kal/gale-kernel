/* SPDX-License-Identifier: MIT */
/*
 * Function prototypes for misc. drm utility functions.
 * Specifically this file is for function prototypes for functions which
 * may also be used outside of drm code (e.g. in fbdev drivers).
 *
 * Copyright (C) 2017 Hans de Goede <hdegoede@redhat.com>
 */

#ifndef __DRM_UTILS_H__
#define __DRM_UTILS_H__

int drm_get_panel_orientation_quirk(int width, int height);

#endif

static inline unsigned long drm_timeout_abs_to_jiffies(int64_t timeout_nsec)
{
	struct timespec64 abs_timeout, timeout, now;
	if (timeout_nsec < 0) return MAX_SCHEDULE_TIMEOUT;
	if (timeout_nsec == 0) return 0;
	abs_timeout = ns_to_timespec64(timeout_nsec);
	ktime_get_ts64(&now);
	timeout = timespec64_sub(abs_timeout, now);
	if (!timespec64_valid_strict(&timeout)) return 0;
	return timespec64_to_jiffies(&timeout) + 1;
}
