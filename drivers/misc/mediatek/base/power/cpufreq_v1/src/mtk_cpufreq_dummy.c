/* SPDX-License-Identifier: GPL-2.0 */
/*
 * Placeholder for mtk_cpufreq_dummy.o referenced by cpufreq_v1 Makefile.
 * The real implementation lives in v2/ (TINYSYS_SSPM_V1 platforms like
 * mt6768) or the plain files above; this TU only satisfies the build.
 */
#include <linux/kernel.h>

void mtk_cpufreq_dummy(void)
{
}
