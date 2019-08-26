Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C68C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3669120874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbfHZLqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:46:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39629 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfHZLqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:46:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2DRv-00013W-DW; Mon, 26 Aug 2019 13:46:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 14C5B1C0DDA;
        Mon, 26 Aug 2019 13:46:15 +0200 (CEST)
Date:   Mon, 26 Aug 2019 11:46:14 -0000
From:   tip-bot2 for Ingo Molnar <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/intel: Fix rename fallout
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156681997497.3432.15184152614666653291.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     26ee9ccc117b9c4179f0a1c65c67f71a0a5a0afe
Gitweb:        https://git.kernel.org/tip/26ee9ccc117b9c4179f0a1c65c67f71a0a5a0afe
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 26 Aug 2019 12:19:06 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 26 Aug 2019 13:06:29 +02:00

x86/cpu/intel: Fix rename fallout

The scripts missed a macro construct of intel_idle.c and other files.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/idle/intel_idle.c                    | 26 +++++++--------
 drivers/platform/x86/intel_pmc_core.c        | 12 +++----
 drivers/platform/x86/intel_pmc_core_pltdrv.c | 12 +++----
 drivers/powercap/intel_rapl_common.c         | 32 +++++++++----------
 4 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index ac58487..347b08b 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1072,26 +1072,26 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	INTEL_CPU_FAM6(ATOM_AIRMONT,		idle_cpu_cht),
 	INTEL_CPU_FAM6(IVYBRIDGE,		idle_cpu_ivb),
 	INTEL_CPU_FAM6(IVYBRIDGE_X,		idle_cpu_ivt),
-	INTEL_CPU_FAM6(HASWELL_CORE,		idle_cpu_hsw),
+	INTEL_CPU_FAM6(HASWELL,			idle_cpu_hsw),
 	INTEL_CPU_FAM6(HASWELL_X,		idle_cpu_hsw),
-	INTEL_CPU_FAM6(HASWELL_ULT,		idle_cpu_hsw),
-	INTEL_CPU_FAM6(HASWELL_GT3E,		idle_cpu_hsw),
-	INTEL_CPU_FAM6(ATOM_SILVERMONT_X,	idle_cpu_avn),
-	INTEL_CPU_FAM6(BROADWELL_CORE,		idle_cpu_bdw),
-	INTEL_CPU_FAM6(BROADWELL_GT3E,		idle_cpu_bdw),
+	INTEL_CPU_FAM6(HASWELL_L,		idle_cpu_hsw),
+	INTEL_CPU_FAM6(HASWELL_G,		idle_cpu_hsw),
+	INTEL_CPU_FAM6(ATOM_SILVERMONT_D,	idle_cpu_avn),
+	INTEL_CPU_FAM6(BROADWELL,		idle_cpu_bdw),
+	INTEL_CPU_FAM6(BROADWELL_G,		idle_cpu_bdw),
 	INTEL_CPU_FAM6(BROADWELL_X,		idle_cpu_bdw),
-	INTEL_CPU_FAM6(BROADWELL_XEON_D,	idle_cpu_bdw),
-	INTEL_CPU_FAM6(SKYLAKE_MOBILE,		idle_cpu_skl),
-	INTEL_CPU_FAM6(SKYLAKE_DESKTOP,		idle_cpu_skl),
-	INTEL_CPU_FAM6(KABYLAKE_MOBILE,		idle_cpu_skl),
-	INTEL_CPU_FAM6(KABYLAKE_DESKTOP,	idle_cpu_skl),
+	INTEL_CPU_FAM6(BROADWELL_D,		idle_cpu_bdw),
+	INTEL_CPU_FAM6(SKYLAKE_L,		idle_cpu_skl),
+	INTEL_CPU_FAM6(SKYLAKE,			idle_cpu_skl),
+	INTEL_CPU_FAM6(KABYLAKE_L,		idle_cpu_skl),
+	INTEL_CPU_FAM6(KABYLAKE,		idle_cpu_skl),
 	INTEL_CPU_FAM6(SKYLAKE_X,		idle_cpu_skx),
 	INTEL_CPU_FAM6(XEON_PHI_KNL,		idle_cpu_knl),
 	INTEL_CPU_FAM6(XEON_PHI_KNM,		idle_cpu_knl),
 	INTEL_CPU_FAM6(ATOM_GOLDMONT,		idle_cpu_bxt),
 	INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS,	idle_cpu_bxt),
-	INTEL_CPU_FAM6(ATOM_GOLDMONT_X,		idle_cpu_dnv),
-	INTEL_CPU_FAM6(ATOM_TREMONT_X,		idle_cpu_dnv),
+	INTEL_CPU_FAM6(ATOM_GOLDMONT_D,		idle_cpu_dnv),
+	INTEL_CPU_FAM6(ATOM_TREMONT_D,		idle_cpu_dnv),
 	{}
 };
 
diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index c510d0d..fd1bfd5 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -806,12 +806,12 @@ static inline void pmc_core_dbgfs_unregister(struct pmc_dev *pmcdev)
 #endif /* CONFIG_DEBUG_FS */
 
 static const struct x86_cpu_id intel_pmc_core_ids[] = {
-	INTEL_CPU_FAM6(SKYLAKE_MOBILE, spt_reg_map),
-	INTEL_CPU_FAM6(SKYLAKE_DESKTOP, spt_reg_map),
-	INTEL_CPU_FAM6(KABYLAKE_MOBILE, spt_reg_map),
-	INTEL_CPU_FAM6(KABYLAKE_DESKTOP, spt_reg_map),
-	INTEL_CPU_FAM6(CANNONLAKE_MOBILE, cnp_reg_map),
-	INTEL_CPU_FAM6(ICELAKE_MOBILE, icl_reg_map),
+	INTEL_CPU_FAM6(SKYLAKE_L, spt_reg_map),
+	INTEL_CPU_FAM6(SKYLAKE, spt_reg_map),
+	INTEL_CPU_FAM6(KABYLAKE_L, spt_reg_map),
+	INTEL_CPU_FAM6(KABYLAKE, spt_reg_map),
+	INTEL_CPU_FAM6(CANNONLAKE_L, cnp_reg_map),
+	INTEL_CPU_FAM6(ICELAKE_L, icl_reg_map),
 	INTEL_CPU_FAM6(ICELAKE_NNPI, icl_reg_map),
 	{}
 };
diff --git a/drivers/platform/x86/intel_pmc_core_pltdrv.c b/drivers/platform/x86/intel_pmc_core_pltdrv.c
index a8754a6..5977e0d 100644
--- a/drivers/platform/x86/intel_pmc_core_pltdrv.c
+++ b/drivers/platform/x86/intel_pmc_core_pltdrv.c
@@ -30,12 +30,12 @@ static struct platform_device pmc_core_device = {
  * other list may grow, but this list should not.
  */
 static const struct x86_cpu_id intel_pmc_core_platform_ids[] = {
-	INTEL_CPU_FAM6(SKYLAKE_MOBILE, pmc_core_device),
-	INTEL_CPU_FAM6(SKYLAKE_DESKTOP, pmc_core_device),
-	INTEL_CPU_FAM6(KABYLAKE_MOBILE, pmc_core_device),
-	INTEL_CPU_FAM6(KABYLAKE_DESKTOP, pmc_core_device),
-	INTEL_CPU_FAM6(CANNONLAKE_MOBILE, pmc_core_device),
-	INTEL_CPU_FAM6(ICELAKE_MOBILE, pmc_core_device),
+	INTEL_CPU_FAM6(SKYLAKE_L, pmc_core_device),
+	INTEL_CPU_FAM6(SKYLAKE, pmc_core_device),
+	INTEL_CPU_FAM6(KABYLAKE_L, pmc_core_device),
+	INTEL_CPU_FAM6(KABYLAKE, pmc_core_device),
+	INTEL_CPU_FAM6(CANNONLAKE_L, pmc_core_device),
+	INTEL_CPU_FAM6(ICELAKE_L, pmc_core_device),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_pmc_core_platform_ids);
diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 6df4818..94ddd7d 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -957,27 +957,27 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	INTEL_CPU_FAM6(IVYBRIDGE, rapl_defaults_core),
 	INTEL_CPU_FAM6(IVYBRIDGE_X, rapl_defaults_core),
 
-	INTEL_CPU_FAM6(HASWELL_CORE, rapl_defaults_core),
-	INTEL_CPU_FAM6(HASWELL_ULT, rapl_defaults_core),
-	INTEL_CPU_FAM6(HASWELL_GT3E, rapl_defaults_core),
+	INTEL_CPU_FAM6(HASWELL, rapl_defaults_core),
+	INTEL_CPU_FAM6(HASWELL_L, rapl_defaults_core),
+	INTEL_CPU_FAM6(HASWELL_G, rapl_defaults_core),
 	INTEL_CPU_FAM6(HASWELL_X, rapl_defaults_hsw_server),
 
-	INTEL_CPU_FAM6(BROADWELL_CORE, rapl_defaults_core),
-	INTEL_CPU_FAM6(BROADWELL_GT3E, rapl_defaults_core),
-	INTEL_CPU_FAM6(BROADWELL_XEON_D, rapl_defaults_core),
+	INTEL_CPU_FAM6(BROADWELL, rapl_defaults_core),
+	INTEL_CPU_FAM6(BROADWELL_G, rapl_defaults_core),
+	INTEL_CPU_FAM6(BROADWELL_D, rapl_defaults_core),
 	INTEL_CPU_FAM6(BROADWELL_X, rapl_defaults_hsw_server),
 
-	INTEL_CPU_FAM6(SKYLAKE_DESKTOP, rapl_defaults_core),
-	INTEL_CPU_FAM6(SKYLAKE_MOBILE, rapl_defaults_core),
+	INTEL_CPU_FAM6(SKYLAKE, rapl_defaults_core),
+	INTEL_CPU_FAM6(SKYLAKE_L, rapl_defaults_core),
 	INTEL_CPU_FAM6(SKYLAKE_X, rapl_defaults_hsw_server),
-	INTEL_CPU_FAM6(KABYLAKE_MOBILE, rapl_defaults_core),
-	INTEL_CPU_FAM6(KABYLAKE_DESKTOP, rapl_defaults_core),
-	INTEL_CPU_FAM6(CANNONLAKE_MOBILE, rapl_defaults_core),
-	INTEL_CPU_FAM6(ICELAKE_MOBILE, rapl_defaults_core),
-	INTEL_CPU_FAM6(ICELAKE_DESKTOP, rapl_defaults_core),
+	INTEL_CPU_FAM6(KABYLAKE_L, rapl_defaults_core),
+	INTEL_CPU_FAM6(KABYLAKE, rapl_defaults_core),
+	INTEL_CPU_FAM6(CANNONLAKE_L, rapl_defaults_core),
+	INTEL_CPU_FAM6(ICELAKE_L, rapl_defaults_core),
+	INTEL_CPU_FAM6(ICELAKE, rapl_defaults_core),
 	INTEL_CPU_FAM6(ICELAKE_NNPI, rapl_defaults_core),
 	INTEL_CPU_FAM6(ICELAKE_X, rapl_defaults_hsw_server),
-	INTEL_CPU_FAM6(ICELAKE_XEON_D, rapl_defaults_hsw_server),
+	INTEL_CPU_FAM6(ICELAKE_D, rapl_defaults_hsw_server),
 
 	INTEL_CPU_FAM6(ATOM_SILVERMONT, rapl_defaults_byt),
 	INTEL_CPU_FAM6(ATOM_AIRMONT, rapl_defaults_cht),
@@ -985,8 +985,8 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	INTEL_CPU_FAM6(ATOM_AIRMONT_MID, rapl_defaults_ann),
 	INTEL_CPU_FAM6(ATOM_GOLDMONT, rapl_defaults_core),
 	INTEL_CPU_FAM6(ATOM_GOLDMONT_PLUS, rapl_defaults_core),
-	INTEL_CPU_FAM6(ATOM_GOLDMONT_X, rapl_defaults_core),
-	INTEL_CPU_FAM6(ATOM_TREMONT_X, rapl_defaults_core),
+	INTEL_CPU_FAM6(ATOM_GOLDMONT_D, rapl_defaults_core),
+	INTEL_CPU_FAM6(ATOM_TREMONT_D, rapl_defaults_core),
 
 	INTEL_CPU_FAM6(XEON_PHI_KNL, rapl_defaults_hsw_server),
 	INTEL_CPU_FAM6(XEON_PHI_KNM, rapl_defaults_hsw_server),
