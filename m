Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8C9C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1653207FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391689AbfIFFmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 01:42:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45575 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403970AbfIFFmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 01:42:12 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i670Z-0008Cr-Vt; Fri, 06 Sep 2019 07:42:08 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 850F71C0744;
        Fri,  6 Sep 2019 07:42:07 +0200 (CEST)
Date:   Fri, 06 Sep 2019 05:42:07 -0000
From:   "tip-bot2 for Rahul Tanwar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Update init data for new Airmont CPU model
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156774852738.13152.9620154124665779711.tip-bot2@tip-bot2>
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

Commit-ID:     0cc5359d8fd45bc410906e009117e78e2b5b2322
Gitweb:        https://git.kernel.org/tip/0cc5359d8fd45bc410906e009117e78e2b5b2322
Author:        Rahul Tanwar <rahul.tanwar@linux.intel.com>
AuthorDate:    Thu, 05 Sep 2019 12:30:20 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Sep 2019 07:30:40 +02:00

x86/cpu: Update init data for new Airmont CPU model

Update properties for newly added Airmont CPU variant.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Cc: Gayatri Kammela <gayatri.kammela@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190905193020.14707-5-tony.luck@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/common.c | 1 +
 arch/x86/kernel/cpu/intel.c  | 1 +
 arch/x86/kernel/tsc_msr.c    | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b6a9e27..030e527 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1059,6 +1059,7 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 	VULNWL_INTEL(CORE_YONAH,		NO_SSB),
 
 	VULNWL_INTEL(ATOM_AIRMONT_MID,		NO_L1TF | MSBDS_ONLY | NO_SWAPGS),
+	VULNWL_INTEL(ATOM_AIRMONT_NP,		NO_L1TF | NO_SWAPGS),
 
 	VULNWL_INTEL(ATOM_GOLDMONT,		NO_MDS | NO_L1TF | NO_SWAPGS),
 	VULNWL_INTEL(ATOM_GOLDMONT_D,		NO_MDS | NO_L1TF | NO_SWAPGS),
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index e2082cc..c2fdc00 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -268,6 +268,7 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 		case INTEL_FAM6_ATOM_SALTWELL_MID:
 		case INTEL_FAM6_ATOM_SALTWELL_TABLET:
 		case INTEL_FAM6_ATOM_SILVERMONT_MID:
+		case INTEL_FAM6_ATOM_AIRMONT_NP:
 			set_cpu_cap(c, X86_FEATURE_NONSTOP_TSC_S3);
 			break;
 		default:
diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
index 067858f..e0cbe4f 100644
--- a/arch/x86/kernel/tsc_msr.c
+++ b/arch/x86/kernel/tsc_msr.c
@@ -58,6 +58,10 @@ static const struct freq_desc freq_desc_ann = {
 	1, { 83300, 100000, 133300, 100000, 0, 0, 0, 0 }
 };
 
+static const struct freq_desc freq_desc_lgm = {
+	1, { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000 }
+};
+
 static const struct x86_cpu_id tsc_msr_cpu_ids[] = {
 	INTEL_CPU_FAM6(ATOM_SALTWELL_MID,	freq_desc_pnw),
 	INTEL_CPU_FAM6(ATOM_SALTWELL_TABLET,	freq_desc_clv),
@@ -65,6 +69,7 @@ static const struct x86_cpu_id tsc_msr_cpu_ids[] = {
 	INTEL_CPU_FAM6(ATOM_SILVERMONT_MID,	freq_desc_tng),
 	INTEL_CPU_FAM6(ATOM_AIRMONT,		freq_desc_cht),
 	INTEL_CPU_FAM6(ATOM_AIRMONT_MID,	freq_desc_ann),
+	INTEL_CPU_FAM6(ATOM_AIRMONT_NP,		freq_desc_lgm),
 	{}
 };
 
