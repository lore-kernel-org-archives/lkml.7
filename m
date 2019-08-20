Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73111C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3145722DBF
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 15:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cWpI7/BD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfHTPyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 11:54:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43832 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbfHTPyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 11:54:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=SS+NC2Xzgt2xH8gYSwwOJarisVb0P7RgpavAaNyK3EI=; b=cWpI7/BDC97YCUbLAcEaWVRzN
        wpacxmsUxzUX0blIMVAwBBi0/rghAq60KDC0ZWcjg3KbtdcPF7sVzxyTo3vA0Vd+alqlg0P86sL65
        17VQ/cGee2b73liDM97xh4du6D8YzNPDBGN5xL8teH5Ct/QTgv6vYHPw122X1GE7mctEctEG1cL0s
        tW8m7Whfwp+4JXZT20l3JvrtbtLel61m57hfoBGl1PcYy6IrRPtMtz5Jkin4BzFQdHiUFxORvRCNF
        VZ+/S8NWFCAeUkaV7S0RZWZR+TKEYHmvT7UbZ2n8CJD+Yjldt9IfPveact7EZZkZWEQM8PewoVV9o
        JtjpohMNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i06SN-00052q-9p; Tue, 20 Aug 2019 15:53:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9D0DC3075FF;
        Tue, 20 Aug 2019 17:53:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E357B20A21FDD; Tue, 20 Aug 2019 17:53:56 +0200 (CEST)
Date:   Tue, 20 Aug 2019 17:53:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS, x86/CPU: Tony Luck will maintain
 asm/intel-family.h
Message-ID: <20190820155356.GI2386@hirez.programming.kicks-ass.net>
References: <20190814234030.30817-1-tony.luck@intel.com>
 <20190815075822.GC15313@zn.tnic>
 <20190815172159.GA4935@agluck-desk2.amr.corp.intel.com>
 <20190815175455.GJ15313@zn.tnic>
 <20190815183055.GA6847@agluck-desk2.amr.corp.intel.com>
 <alpine.DEB.2.21.1908152217070.1908@nanos.tec.linutronix.de>
 <20190820154011.GY2332@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820154011.GY2332@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 05:40:11PM +0200, Peter Zijlstra wrote:
> > _ULT
> > _MOBILE
> 
> I suspect these two are the same.

for i in `git grep -l "INTEL_FAM6_.*_MOBILE"`
do
	sed -i -e 's/\(INTEL_FAM6_.*\)_MOBILE/\1_ULT/g' ${i}
done

---
 arch/x86/events/intel/core.c          | 16 +++++++--------
 arch/x86/events/intel/cstate.c        | 14 ++++++-------
 arch/x86/events/intel/rapl.c          |  8 ++++----
 arch/x86/events/intel/uncore.c        |  6 +++---
 arch/x86/events/msr.c                 |  6 +++---
 arch/x86/include/asm/intel-family.h   |  8 ++++----
 arch/x86/kernel/apic/apic.c           |  4 ++--
 arch/x86/kernel/cpu/bugs.c            |  4 ++--
 arch/x86/kernel/cpu/intel.c           |  4 ++--
 drivers/cpufreq/intel_pstate.c        |  2 +-
 tools/power/x86/turbostat/turbostat.c | 38 +++++++++++++++++------------------
 11 files changed, 55 insertions(+), 55 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 76bff3a33725..a0945aa897d6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3978,13 +3978,13 @@ static const struct x86_cpu_desc isolation_ucodes[] = {
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_X,		 2, 0x0b000014),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 3, 0x00000021),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 4, 0x00000000),
-	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_MOBILE,	 3, 0x0000007c),
+	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_ULT,		 3, 0x0000007c),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE,		 3, 0x0000007c),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		 9, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	 9, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	10, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	11, 0x0000004e),
-	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_MOBILE,	12, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_ULT,		 9, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_ULT,		10, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_ULT,		11, 0x0000004e),
+	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE_ULT,		12, 0x0000004e),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		10, 0x0000004e),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		11, 0x0000004e),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		12, 0x0000004e),
@@ -4955,9 +4955,9 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_SKYLAKE_X:
 		pmem = true;
 		/* fall through */
-	case INTEL_FAM6_SKYLAKE_MOBILE:
+	case INTEL_FAM6_SKYLAKE_ULT:
 	case INTEL_FAM6_SKYLAKE:
-	case INTEL_FAM6_KABYLAKE_MOBILE:
+	case INTEL_FAM6_KABYLAKE_ULT:
 	case INTEL_FAM6_KABYLAKE:
 		x86_add_quirk(intel_pebs_isolation_quirk);
 		x86_pmu.late_ack = true;
@@ -5005,7 +5005,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_ICELAKE_XEON_D:
 		pmem = true;
 		/* fall through */
-	case INTEL_FAM6_ICELAKE_MOBILE:
+	case INTEL_FAM6_ICELAKE_ULT:
 	case INTEL_FAM6_ICELAKE:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 3854400ad8ff..39c48a0dc6dc 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -608,14 +608,14 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_GT3E,   snb_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_BROADWELL_X,      snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_MOBILE, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE,        snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_X,      snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_ULT, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE,     snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_SKYLAKE_X,   snb_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_MOBILE, hswult_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE_ULT, hswult_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_KABYLAKE,        hswult_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_CANNONLAKE_MOBILE, cnl_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_CANNONLAKE_ULT, cnl_cstates),
 
 	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNL, knl_cstates),
 	X86_CSTATES_MODEL(INTEL_FAM6_XEON_PHI_KNM, knl_cstates),
@@ -625,8 +625,8 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 
 	X86_CSTATES_MODEL(INTEL_FAM6_ATOM_GOLDMONT_PLUS, glm_cstates),
 
-	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_MOBILE, snb_cstates),
-	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE,        snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE_ULT, snb_cstates),
+	X86_CSTATES_MODEL(INTEL_FAM6_ICELAKE,     snb_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index c1278e2764f4..1b0c49ed9bb8 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -730,16 +730,16 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_XEON_D,	model_hsx),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,		model_knl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM,		model_knl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_MOBILE,		model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_ULT,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_X,		model_hsx),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE,	model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_ULT,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE,		model_skl),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_CANNONLAKE_MOBILE,	model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_CANNONLAKE_ULT,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT,		model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_X,	model_hsw),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT_PLUS,	model_hsw),
-	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE,		model_skl),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE_ULT,		model_skl),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ICELAKE,		model_skl),
 	{},
 };
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index d5e091586242..6e23a40a5f70 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1466,11 +1466,11 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,	  knl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM,	  knl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE,	  skl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_MOBILE, skl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_ULT,	  skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_X,      skx_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE, skl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE_ULT,	  skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_KABYLAKE,	  skl_uncore_init),
-	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_MOBILE, icl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_ULT,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE_NNPI,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ICELAKE,	  icl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_ATOM_TREMONT_X, snr_uncore_init),
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 08d320a39dff..5409ce19efe5 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -84,12 +84,12 @@ static bool test_intel(int idx, void *data)
 			return true;
 		break;
 
-	case INTEL_FAM6_SKYLAKE_MOBILE:
+	case INTEL_FAM6_SKYLAKE_ULT:
 	case INTEL_FAM6_SKYLAKE:
 	case INTEL_FAM6_SKYLAKE_X:
-	case INTEL_FAM6_KABYLAKE_MOBILE:
+	case INTEL_FAM6_KABYLAKE_ULT:
 	case INTEL_FAM6_KABYLAKE:
-	case INTEL_FAM6_ICELAKE_MOBILE:
+	case INTEL_FAM6_ICELAKE_ULT:
 		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
 			return true;
 		break;
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 800dd17e61c4..14a99a8fea91 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -59,18 +59,18 @@
 #define INTEL_FAM6_BROADWELL_X		0x4F
 #define INTEL_FAM6_BROADWELL_XEON_D	0x56
 
-#define INTEL_FAM6_SKYLAKE_MOBILE	0x4E
+#define INTEL_FAM6_SKYLAKE_ULT		0x4E
 #define INTEL_FAM6_SKYLAKE		0x5E
 #define INTEL_FAM6_SKYLAKE_X		0x55
-#define INTEL_FAM6_KABYLAKE_MOBILE	0x8E
+#define INTEL_FAM6_KABYLAKE_ULT		0x8E
 #define INTEL_FAM6_KABYLAKE		0x9E
 
-#define INTEL_FAM6_CANNONLAKE_MOBILE	0x66
+#define INTEL_FAM6_CANNONLAKE_ULT	0x66
 
 #define INTEL_FAM6_ICELAKE_X		0x6A
 #define INTEL_FAM6_ICELAKE_XEON_D	0x6C
 #define INTEL_FAM6_ICELAKE		0x7D
-#define INTEL_FAM6_ICELAKE_MOBILE	0x7E
+#define INTEL_FAM6_ICELAKE_ULT		0x7E
 #define INTEL_FAM6_ICELAKE_NNPI		0x9D
 
 /* "Small Core" Processors (Atom) */
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index e0bc8a27a166..6572da0bfebb 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -600,10 +600,10 @@ static const struct x86_cpu_id deadline_match[] = {
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL,	0x25),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_BROADWELL_GT3E,	0x17),
 
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE_MOBILE,	0xb2),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE_ULT,	0xb2),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_SKYLAKE,		0xb2),
 
-	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_KABYLAKE_MOBILE,	0x52),
+	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_KABYLAKE_ULT,	0x52),
 	DEADLINE_MODEL_MATCH_REV ( INTEL_FAM6_KABYLAKE,		0x52),
 
 	{},
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 21d8f58bec31..55db2a6b68df 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1189,9 +1189,9 @@ static void override_cache_bits(struct cpuinfo_x86 *c)
 	case INTEL_FAM6_HASWELL_GT3E:
 	case INTEL_FAM6_BROADWELL:
 	case INTEL_FAM6_BROADWELL_GT3E:
-	case INTEL_FAM6_SKYLAKE_MOBILE:
+	case INTEL_FAM6_SKYLAKE_ULT:
 	case INTEL_FAM6_SKYLAKE:
-	case INTEL_FAM6_KABYLAKE_MOBILE:
+	case INTEL_FAM6_KABYLAKE_ULT:
 	case INTEL_FAM6_KABYLAKE:
 		if (c->x86_cache_bits < 44)
 			c->x86_cache_bits = 44;
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 92287fff158e..febd14b7dbf6 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -145,8 +145,8 @@ static const struct sku_microcode spectre_bad_microcodes[] = {
 	{ INTEL_FAM6_KABYLAKE,		0x0B,	0x80 },
 	{ INTEL_FAM6_KABYLAKE,		0x0A,	0x80 },
 	{ INTEL_FAM6_KABYLAKE,		0x09,	0x80 },
-	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x0A,	0x80 },
-	{ INTEL_FAM6_KABYLAKE_MOBILE,	0x09,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_ULT,	0x0A,	0x80 },
+	{ INTEL_FAM6_KABYLAKE_ULT,	0x09,	0x80 },
 	{ INTEL_FAM6_SKYLAKE_X,		0x03,	0x0100013e },
 	{ INTEL_FAM6_SKYLAKE_X,		0x04,	0x0200003c },
 	{ INTEL_FAM6_BROADWELL,		0x04,	0x28 },
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 17cb9af25328..653aaa63bbdf 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1879,7 +1879,7 @@ static const struct x86_cpu_id intel_pstate_cpu_ids[] = {
 	ICPU(INTEL_FAM6_HASWELL_GT3E,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_GT3E,		core_funcs),
 	ICPU(INTEL_FAM6_ATOM_AIRMONT,		airmont_funcs),
-	ICPU(INTEL_FAM6_SKYLAKE_MOBILE,		core_funcs),
+	ICPU(INTEL_FAM6_SKYLAKE_ULT,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_X,		core_funcs),
 	ICPU(INTEL_FAM6_SKYLAKE,		core_funcs),
 	ICPU(INTEL_FAM6_BROADWELL_XEON_D,	core_funcs),
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 8083a354ae7f..191255045bd9 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3213,8 +3213,8 @@ int probe_nhm_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
-	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
-	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
+	case INTEL_FAM6_SKYLAKE_ULT:	/* SKL */
+	case INTEL_FAM6_CANNONLAKE_ULT:	/* CNL */
 		pkg_cstate_limits = hsw_pkg_cstate_limits;
 		has_misc_feature_control = 1;
 		break;
@@ -3409,8 +3409,8 @@ int has_config_tdp(unsigned int family, unsigned int model)
 	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
-	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
-	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
+	case INTEL_FAM6_SKYLAKE_ULT:	/* SKL */
+	case INTEL_FAM6_CANNONLAKE_ULT:	/* CNL */
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 
 	case INTEL_FAM6_XEON_PHI_KNL:	/* Knights Landing */
@@ -3863,8 +3863,8 @@ void rapl_probe_intel(unsigned int family, unsigned int model)
 		else
 			BIC_PRESENT(BIC_PkgWatt);
 		break;
-	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
-	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
+	case INTEL_FAM6_SKYLAKE_ULT:	/* SKL */
+	case INTEL_FAM6_CANNONLAKE_ULT:	/* CNL */
 		do_rapl = RAPL_PKG | RAPL_CORES | RAPL_CORE_POLICY | RAPL_DRAM | RAPL_DRAM_PERF_STATUS | RAPL_PKG_PERF_STATUS | RAPL_GFX | RAPL_PKG_POWER_INFO;
 		BIC_PRESENT(BIC_PKG__);
 		BIC_PRESENT(BIC_RAM__);
@@ -4255,8 +4255,8 @@ int has_snb_msrs(unsigned int family, unsigned int model)
 	case INTEL_FAM6_BROADWELL:	/* BDW */
 	case INTEL_FAM6_BROADWELL_GT3E:	/* BDW */
 	case INTEL_FAM6_BROADWELL_X:	/* BDX */
-	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
-	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
+	case INTEL_FAM6_SKYLAKE_ULT:	/* SKL */
+	case INTEL_FAM6_CANNONLAKE_ULT:	/* CNL */
 	case INTEL_FAM6_SKYLAKE_X:	/* SKX */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
@@ -4286,8 +4286,8 @@ int has_hsw_msrs(unsigned int family, unsigned int model)
 	switch (model) {
 	case INTEL_FAM6_HASWELL:
 	case INTEL_FAM6_BROADWELL:	/* BDW */
-	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
-	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
+	case INTEL_FAM6_SKYLAKE_ULT:	/* SKL */
+	case INTEL_FAM6_CANNONLAKE_ULT:	/* CNL */
 	case INTEL_FAM6_ATOM_GOLDMONT:	/* BXT */
 	case INTEL_FAM6_ATOM_GOLDMONT_PLUS:
 		return 1;
@@ -4309,8 +4309,8 @@ int has_skl_msrs(unsigned int family, unsigned int model)
 		return 0;
 
 	switch (model) {
-	case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
-	case INTEL_FAM6_CANNONLAKE_MOBILE:	/* CNL */
+	case INTEL_FAM6_SKYLAKE_ULT:	/* SKL */
+	case INTEL_FAM6_CANNONLAKE_ULT:	/* CNL */
 		return 1;
 	}
 	return 0;
@@ -4345,7 +4345,7 @@ int is_cnl(unsigned int family, unsigned int model)
 		return 0;
 
 	switch (model) {
-	case INTEL_FAM6_CANNONLAKE_MOBILE: /* CNL */
+	case INTEL_FAM6_CANNONLAKE_ULT: /* CNL */
 		return 1;
 	}
 
@@ -4575,14 +4575,14 @@ unsigned int intel_model_duplicates(unsigned int model)
 	case INTEL_FAM6_BROADWELL_XEON_D:	/* BDX-DE */
 		return INTEL_FAM6_BROADWELL_X;
 
-	case INTEL_FAM6_SKYLAKE_MOBILE:
+	case INTEL_FAM6_SKYLAKE_ULT:
 	case INTEL_FAM6_SKYLAKE:
-	case INTEL_FAM6_KABYLAKE_MOBILE:
+	case INTEL_FAM6_KABYLAKE_ULT:
 	case INTEL_FAM6_KABYLAKE:
-		return INTEL_FAM6_SKYLAKE_MOBILE;
+		return INTEL_FAM6_SKYLAKE_ULT;
 
-	case INTEL_FAM6_ICELAKE_MOBILE:
-		return INTEL_FAM6_CANNONLAKE_MOBILE;
+	case INTEL_FAM6_ICELAKE_ULT:
+		return INTEL_FAM6_CANNONLAKE_ULT;
 	}
 	return model;
 }
@@ -4731,7 +4731,7 @@ void process_cpuid()
 
 			if (crystal_hz == 0)
 				switch(model) {
-				case INTEL_FAM6_SKYLAKE_MOBILE:	/* SKL */
+				case INTEL_FAM6_SKYLAKE_ULT:	/* SKL */
 					crystal_hz = 24000000;	/* 24.0 MHz */
 					break;
 				case INTEL_FAM6_ATOM_GOLDMONT_X:	/* DNV */
