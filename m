Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D41EC43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B64220665
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Hi9X4GF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfFVKRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:17:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36757 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfFVKRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:17:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MAH0BG2098706
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:17:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MAH0BG2098706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561198622;
        bh=JXa8+VKwO9s6wv3fszlsbchVA7gIhY2It1hWyy2kltU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Hi9X4GF1XLZNhpMWc2wQwqg/6IQAteD5i9c1A8BKbTTWHFNyysFh1I0uOvGH+3OQH
         MrwDQquNo5s8iX3oF+akqV2MMyVVChTg+T7Szyp3RBVJ2o9baSQrj/3y82bQaFTxhA
         YAGPPGc/dfMRIqun40u6frMHPv1OSaYwredRMYseERREzm9AOgT6Nn7Nj8Z4Vt05x/
         EaJhIhCIu1uu4Th/vxs9JCn2xpaZhmTp909tKWKX2W1JEvD5a002iTAbzXJEJhIr+9
         /9sZeo97S31E+Wkke2WqozQGxHXBvlAuNnpzB72Flnlq7xvzfDHEp/m2QSaq3Z5UKU
         JZixyzvQnxaLQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MAGxgx2098701;
        Sat, 22 Jun 2019 03:16:59 -0700
Date:   Sat, 22 Jun 2019 03:16:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony W Wang-oc <tipbot@zytor.com>
Message-ID: <tip-761fdd5e3327db6c646a09bab5ad48cd42680cd2@git.kernel.org>
Cc:     TonyWWang-oc@zhaoxin.com, rjw@rjwysocki.net, tglx@linutronix.de,
        gregkh@linuxfoundation.org, QiyuanWang@zhaoxin.com,
        mingo@kernel.org, DavidWang@zhaoxin.com, lenb@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, HerryYang@zhaoxin.com,
        CooperYan@zhaoxin.com
Reply-To: HerryYang@zhaoxin.com, CooperYan@zhaoxin.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com, lenb@kernel.org,
          gregkh@linuxfoundation.org, QiyuanWang@zhaoxin.com,
          mingo@kernel.org, DavidWang@zhaoxin.com, tglx@linutronix.de,
          rjw@rjwysocki.net, TonyWWang-oc@zhaoxin.com
In-Reply-To: <01042674b2f741b2aed1f797359bdffb@zhaoxin.com>
References: <01042674b2f741b2aed1f797359bdffb@zhaoxin.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/cpu: Create Zhaoxin processors architecture
 support file
Git-Commit-ID: 761fdd5e3327db6c646a09bab5ad48cd42680cd2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  761fdd5e3327db6c646a09bab5ad48cd42680cd2
Gitweb:     https://git.kernel.org/tip/761fdd5e3327db6c646a09bab5ad48cd42680cd2
Author:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
AuthorDate: Tue, 18 Jun 2019 08:37:05 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:45:57 +0200

x86/cpu: Create Zhaoxin processors architecture support file

Add x86 architecture support for new Zhaoxin processors.
Carve out initialization code needed by Zhaoxin processors into
a separate compilation unit.

To identify Zhaoxin CPU, add a new vendor type X86_VENDOR_ZHAOXIN
for system recognition.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "hpa@zytor.com" <hpa@zytor.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Cc: "lenb@kernel.org" <lenb@kernel.org>
Cc: David Wang <DavidWang@zhaoxin.com>
Cc: "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>
Cc: "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>
Cc: "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Link: https://lkml.kernel.org/r/01042674b2f741b2aed1f797359bdffb@zhaoxin.com

---
 MAINTAINERS                      |   6 ++
 arch/x86/Kconfig.cpu             |  13 +++
 arch/x86/include/asm/processor.h |   3 +-
 arch/x86/kernel/cpu/Makefile     |   1 +
 arch/x86/kernel/cpu/zhaoxin.c    | 167 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 189 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 57f496cff999..dfdefc6cb3a2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17477,6 +17477,12 @@ Q:	https://patchwork.linuxtv.org/project/linux-media/list/
 S:	Maintained
 F:	drivers/media/dvb-frontends/zd1301_demod*
 
+ZHAOXIN PROCESSOR SUPPORT
+M:	Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	arch/x86/kernel/cpu/zhaoxin.c
+
 ZPOOL COMPRESSED PAGE STORAGE API
 M:	Dan Streetman <ddstreet@ieee.org>
 L:	linux-mm@kvack.org
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 6adce15268bd..8e29c991ba3e 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -480,3 +480,16 @@ config CPU_SUP_UMC_32
 	  CPU might render the kernel unbootable.
 
 	  If unsure, say N.
+
+config CPU_SUP_ZHAOXIN
+	default y
+	bool "Support Zhaoxin processors" if PROCESSOR_SELECT
+	help
+	  This enables detection, tunings and quirks for Zhaoxin processors
+
+	  You need this enabled if you want your kernel to run on a
+	  Zhaoxin CPU. Disabling this option on other types of CPUs
+	  makes the kernel a tiny bit smaller. Disabling it on a Zhaoxin
+	  CPU might render the kernel unbootable.
+
+	  If unsure, say N.
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c34a35c78618..e57d2ca2ed87 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -144,7 +144,8 @@ enum cpuid_regs_idx {
 #define X86_VENDOR_TRANSMETA	7
 #define X86_VENDOR_NSC		8
 #define X86_VENDOR_HYGON	9
-#define X86_VENDOR_NUM		10
+#define X86_VENDOR_ZHAOXIN	10
+#define X86_VENDOR_NUM		11
 
 #define X86_VENDOR_UNKNOWN	0xff
 
diff --git a/arch/x86/kernel/cpu/Makefile b/arch/x86/kernel/cpu/Makefile
index 5102bf7c8192..a7d9a4cb3ab6 100644
--- a/arch/x86/kernel/cpu/Makefile
+++ b/arch/x86/kernel/cpu/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_CPU_SUP_CYRIX_32)		+= cyrix.o
 obj-$(CONFIG_CPU_SUP_CENTAUR)		+= centaur.o
 obj-$(CONFIG_CPU_SUP_TRANSMETA_32)	+= transmeta.o
 obj-$(CONFIG_CPU_SUP_UMC_32)		+= umc.o
+obj-$(CONFIG_CPU_SUP_ZHAOXIN)		+= zhaoxin.o
 
 obj-$(CONFIG_X86_MCE)			+= mce/
 obj-$(CONFIG_MTRR)			+= mtrr/
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
new file mode 100644
index 000000000000..8e6f2f4b4afe
--- /dev/null
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/sched.h>
+#include <linux/sched/clock.h>
+
+#include <asm/cpufeature.h>
+
+#include "cpu.h"
+
+#define MSR_ZHAOXIN_FCR57 0x00001257
+
+#define ACE_PRESENT	(1 << 6)
+#define ACE_ENABLED	(1 << 7)
+#define ACE_FCR		(1 << 7)	/* MSR_ZHAOXIN_FCR */
+
+#define RNG_PRESENT	(1 << 2)
+#define RNG_ENABLED	(1 << 3)
+#define RNG_ENABLE	(1 << 8)	/* MSR_ZHAOXIN_RNG */
+
+#define X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW	0x00200000
+#define X86_VMX_FEATURE_PROC_CTLS_VNMI		0x00400000
+#define X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS	0x80000000
+#define X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC	0x00000001
+#define X86_VMX_FEATURE_PROC_CTLS2_EPT		0x00000002
+#define X86_VMX_FEATURE_PROC_CTLS2_VPID		0x00000020
+
+static void init_zhaoxin_cap(struct cpuinfo_x86 *c)
+{
+	u32  lo, hi;
+
+	/* Test for Extended Feature Flags presence */
+	if (cpuid_eax(0xC0000000) >= 0xC0000001) {
+		u32 tmp = cpuid_edx(0xC0000001);
+
+		/* Enable ACE unit, if present and disabled */
+		if ((tmp & (ACE_PRESENT | ACE_ENABLED)) == ACE_PRESENT) {
+			rdmsr(MSR_ZHAOXIN_FCR57, lo, hi);
+			/* Enable ACE unit */
+			lo |= ACE_FCR;
+			wrmsr(MSR_ZHAOXIN_FCR57, lo, hi);
+			pr_info("CPU: Enabled ACE h/w crypto\n");
+		}
+
+		/* Enable RNG unit, if present and disabled */
+		if ((tmp & (RNG_PRESENT | RNG_ENABLED)) == RNG_PRESENT) {
+			rdmsr(MSR_ZHAOXIN_FCR57, lo, hi);
+			/* Enable RNG unit */
+			lo |= RNG_ENABLE;
+			wrmsr(MSR_ZHAOXIN_FCR57, lo, hi);
+			pr_info("CPU: Enabled h/w RNG\n");
+		}
+
+		/*
+		 * Store Extended Feature Flags as word 5 of the CPU
+		 * capability bit array
+		 */
+		c->x86_capability[CPUID_C000_0001_EDX] = cpuid_edx(0xC0000001);
+	}
+
+	if (c->x86 >= 0x6)
+		set_cpu_cap(c, X86_FEATURE_REP_GOOD);
+
+	cpu_detect_cache_sizes(c);
+}
+
+static void early_init_zhaoxin(struct cpuinfo_x86 *c)
+{
+	if (c->x86 >= 0x6)
+		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
+#ifdef CONFIG_X86_64
+	set_cpu_cap(c, X86_FEATURE_SYSENTER32);
+#endif
+	if (c->x86_power & (1 << 8)) {
+		set_cpu_cap(c, X86_FEATURE_CONSTANT_TSC);
+		set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC);
+	}
+
+	if (c->cpuid_level >= 0x00000001) {
+		u32 eax, ebx, ecx, edx;
+
+		cpuid(0x00000001, &eax, &ebx, &ecx, &edx);
+		/*
+		 * If HTT (EDX[28]) is set EBX[16:23] contain the number of
+		 * apicids which are reserved per package. Store the resulting
+		 * shift value for the package management code.
+		 */
+		if (edx & (1U << 28))
+			c->x86_coreid_bits = get_count_order((ebx >> 16) & 0xff);
+	}
+
+}
+
+static void zhaoxin_detect_vmx_virtcap(struct cpuinfo_x86 *c)
+{
+	u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;
+
+	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low, vmx_msr_high);
+	msr_ctl = vmx_msr_high | vmx_msr_low;
+
+	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW)
+		set_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
+	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_VNMI)
+		set_cpu_cap(c, X86_FEATURE_VNMI);
+	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS) {
+		rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
+		      vmx_msr_low, vmx_msr_high);
+		msr_ctl2 = vmx_msr_high | vmx_msr_low;
+		if ((msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC) &&
+		    (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW))
+			set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
+		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT)
+			set_cpu_cap(c, X86_FEATURE_EPT);
+		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
+			set_cpu_cap(c, X86_FEATURE_VPID);
+	}
+}
+
+static void init_zhaoxin(struct cpuinfo_x86 *c)
+{
+	early_init_zhaoxin(c);
+	init_intel_cacheinfo(c);
+	detect_num_cpu_cores(c);
+#ifdef CONFIG_X86_32
+	detect_ht(c);
+#endif
+
+	if (c->cpuid_level > 9) {
+		unsigned int eax = cpuid_eax(10);
+
+		/*
+		 * Check for version and the number of counters
+		 * Version(eax[7:0]) can't be 0;
+		 * Counters(eax[15:8]) should be greater than 1;
+		 */
+		if ((eax & 0xff) && (((eax >> 8) & 0xff) > 1))
+			set_cpu_cap(c, X86_FEATURE_ARCH_PERFMON);
+	}
+
+	if (c->x86 >= 0x6)
+		init_zhaoxin_cap(c);
+#ifdef CONFIG_X86_64
+	set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
+#endif
+
+	if (cpu_has(c, X86_FEATURE_VMX))
+		zhaoxin_detect_vmx_virtcap(c);
+}
+
+#ifdef CONFIG_X86_32
+static unsigned int
+zhaoxin_size_cache(struct cpuinfo_x86 *c, unsigned int size)
+{
+	return size;
+}
+#endif
+
+static const struct cpu_dev zhaoxin_cpu_dev = {
+	.c_vendor	= "zhaoxin",
+	.c_ident	= { "  Shanghai  " },
+	.c_early_init	= early_init_zhaoxin,
+	.c_init		= init_zhaoxin,
+#ifdef CONFIG_X86_32
+	.legacy_cache_size = zhaoxin_size_cache,
+#endif
+	.c_x86_vendor	= X86_VENDOR_ZHAOXIN,
+};
+
+cpu_dev_register(zhaoxin_cpu_dev);
