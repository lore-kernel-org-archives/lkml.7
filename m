Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421EEC5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080462084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388126AbfKGKVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:21:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:47094 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387779AbfKGKVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:21:09 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iSeuM-00034m-GU; Thu, 07 Nov 2019 11:20:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id ADE681C03AB;
        Thu,  7 Nov 2019 11:20:53 +0100 (CET)
Date:   Thu, 07 Nov 2019 10:20:53 -0000
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/Kconfig: Rename UMIP config parameter
Cc:     Babu Moger <babu.moger@amd.com>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <157298912544.17462.2018334793891409521.stgit@naples-babu.amd.com>
References: <157298912544.17462.2018334793891409521.stgit@naples-babu.amd.com>
MIME-Version: 1.0
Message-ID: <157312205338.29376.6775745697687176487.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     b971880fe79f4042aaaf426744a5b19521bf77b3
Gitweb:        https://git.kernel.org/tip/b971880fe79f4042aaaf426744a5b19521bf77b3
Author:        Babu Moger <Babu.Moger@amd.com>
AuthorDate:    Tue, 05 Nov 2019 21:25:32 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 Nov 2019 11:07:29 +01:00

x86/Kconfig: Rename UMIP config parameter

AMD 2nd generation EPYC processors support the UMIP (User-Mode
Instruction Prevention) feature. So, rename X86_INTEL_UMIP to
generic X86_UMIP and modify the text to cover both Intel and AMD.

 [ bp: take of the disabled-features.h copy in tools/ too. ]

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "x86@kernel.org" <x86@kernel.org>
Link: https://lkml.kernel.org/r/157298912544.17462.2018334793891409521.stgit@naples-babu.amd.com
---
 arch/x86/Kconfig                               | 16 ++++++++--------
 arch/x86/include/asm/disabled-features.h       |  2 +-
 arch/x86/include/asm/umip.h                    |  4 ++--
 arch/x86/kernel/Makefile                       |  2 +-
 tools/arch/x86/include/asm/disabled-features.h |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 896f840..434fae9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1880,16 +1880,16 @@ config X86_SMAP
 
 	  If unsure, say Y.
 
-config X86_INTEL_UMIP
+config X86_UMIP
 	def_bool y
-	depends on CPU_SUP_INTEL
-	prompt "Intel User Mode Instruction Prevention" if EXPERT
+	depends on CPU_SUP_INTEL || CPU_SUP_AMD
+	prompt "User Mode Instruction Prevention" if EXPERT
 	---help---
-	  The User Mode Instruction Prevention (UMIP) is a security
-	  feature in newer Intel processors. If enabled, a general
-	  protection fault is issued if the SGDT, SLDT, SIDT, SMSW
-	  or STR instructions are executed in user mode. These instructions
-	  unnecessarily expose information about the hardware state.
+	  User Mode Instruction Prevention (UMIP) is a security feature in
+	  some x86 processors. If enabled, a general protection fault is
+	  issued if the SGDT, SLDT, SIDT, SMSW or STR instructions are
+	  executed in user mode. These instructions unnecessarily expose
+	  information about the hardware state.
 
 	  The vast majority of applications do not use these instructions.
 	  For the very few that do, software emulation is provided in
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index a5ea841..8e1d0bb 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -22,7 +22,7 @@
 # define DISABLE_SMAP	(1<<(X86_FEATURE_SMAP & 31))
 #endif
 
-#ifdef CONFIG_X86_INTEL_UMIP
+#ifdef CONFIG_X86_UMIP
 # define DISABLE_UMIP	0
 #else
 # define DISABLE_UMIP	(1<<(X86_FEATURE_UMIP & 31))
diff --git a/arch/x86/include/asm/umip.h b/arch/x86/include/asm/umip.h
index db43f2a..aeed98c 100644
--- a/arch/x86/include/asm/umip.h
+++ b/arch/x86/include/asm/umip.h
@@ -4,9 +4,9 @@
 #include <linux/types.h>
 #include <asm/ptrace.h>
 
-#ifdef CONFIG_X86_INTEL_UMIP
+#ifdef CONFIG_X86_UMIP
 bool fixup_umip_exception(struct pt_regs *regs);
 #else
 static inline bool fixup_umip_exception(struct pt_regs *regs) { return false; }
-#endif  /* CONFIG_X86_INTEL_UMIP */
+#endif  /* CONFIG_X86_UMIP */
 #endif  /* _ASM_X86_UMIP_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 3578ad2..52ce1e2 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -134,7 +134,7 @@ obj-$(CONFIG_EFI)			+= sysfb_efi.o
 obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o
 obj-$(CONFIG_TRACING)			+= tracepoint.o
 obj-$(CONFIG_SCHED_MC_PRIO)		+= itmt.o
-obj-$(CONFIG_X86_INTEL_UMIP)		+= umip.o
+obj-$(CONFIG_X86_UMIP)			+= umip.o
 
 obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
index a5ea841..8e1d0bb 100644
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ b/tools/arch/x86/include/asm/disabled-features.h
@@ -22,7 +22,7 @@
 # define DISABLE_SMAP	(1<<(X86_FEATURE_SMAP & 31))
 #endif
 
-#ifdef CONFIG_X86_INTEL_UMIP
+#ifdef CONFIG_X86_UMIP
 # define DISABLE_UMIP	0
 #else
 # define DISABLE_UMIP	(1<<(X86_FEATURE_UMIP & 31))
