Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1959C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81272084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:37:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WOevYKLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbfFQOho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:37:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57883 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfFQOhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:37:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HEZXEZ3458254
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 07:35:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HEZXEZ3458254
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560782133;
        bh=4hncbt1LWhYoVSvdFd3Cdu5iiQIVCUM3j+5IEinrDM0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=WOevYKLKWjiwDv29DZirLuwci1c+ddzFeBGjO+9jO3FR1yRtBHPDmUA/VeJLFJfws
         0GjsCkPvL2KTKPaTYnhGDEHEjVn5dwx5xUHA+vjrPrsXSZ304x99Ms43S00w1AW9ww
         cmn6MvtBNWtEvH2LKxscqRJOJ9Gsu3brEFMOueYSzz9ZSfhBMRAewUqiPPI0kZozze
         ziGhiLca8/tm0+DM30p5ZU81u/bcliYt3k8ucHNSvkUS9zE/p0I4VcKFJH6qmwWZVX
         Tesnw1BdprNK7nHb+WvOr9B/qOndiCRVKLEnMK7nrs5WRyZ3oSDW985LWIFVAYwdSV
         taMw4+YNMOK+Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HEZXLJ3458251;
        Mon, 17 Jun 2019 07:35:33 -0700
Date:   Mon, 17 Jun 2019 07:35:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-faaeff98666c24376cebd0b106504d05a36881d1@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, peterz@infradead.org, hpa@zytor.com,
        mingo@kernel.org, torvalds@linux-foundation.org
Reply-To: hpa@zytor.com, mingo@kernel.org, torvalds@linux-foundation.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          kan.liang@linux.intel.com, peterz@infradead.org
In-Reply-To: <20190603134122.13853-2-kan.liang@linux.intel.com>
References: <20190603134122.13853-2-kan.liang@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Add more Icelake CPUIDs
Git-Commit-ID: faaeff98666c24376cebd0b106504d05a36881d1
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

Commit-ID:  faaeff98666c24376cebd0b106504d05a36881d1
Gitweb:     https://git.kernel.org/tip/faaeff98666c24376cebd0b106504d05a36881d1
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 3 Jun 2019 06:41:21 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 17 Jun 2019 12:36:16 +0200

perf/x86/intel: Add more Icelake CPUIDs

Add new model number for Icelake desktop and server to perf.

The data source encoding for Icelake server is the same as Skylake
server.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bp@alien8.de
Cc: qiuxu.zhuo@intel.com
Cc: rui.zhang@intel.com
Cc: tony.luck@intel.com
Link: https://lkml.kernel.org/r/20190603134122.13853-2-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 71001f005bfe..4377bf6a6f82 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4485,6 +4485,7 @@ __init int intel_pmu_init(void)
 	struct event_constraint *c;
 	unsigned int unused;
 	struct extra_reg *er;
+	bool pmem = false;
 	int version, i;
 	char *name;
 
@@ -4936,9 +4937,10 @@ __init int intel_pmu_init(void)
 		name = "knights-landing";
 		break;
 
+	case INTEL_FAM6_SKYLAKE_X:
+		pmem = true;
 	case INTEL_FAM6_SKYLAKE_MOBILE:
 	case INTEL_FAM6_SKYLAKE_DESKTOP:
-	case INTEL_FAM6_SKYLAKE_X:
 	case INTEL_FAM6_KABYLAKE_MOBILE:
 	case INTEL_FAM6_KABYLAKE_DESKTOP:
 		x86_add_quirk(intel_pebs_isolation_quirk);
@@ -4970,8 +4972,7 @@ __init int intel_pmu_init(void)
 		td_attr  = hsw_events_attrs;
 		mem_attr = hsw_mem_events_attrs;
 		tsx_attr = hsw_tsx_events_attrs;
-		intel_pmu_pebs_data_source_skl(
-			boot_cpu_data.x86_model == INTEL_FAM6_SKYLAKE_X);
+		intel_pmu_pebs_data_source_skl(pmem);
 
 		if (boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
 			x86_pmu.flags |= PMU_FL_TFA;
@@ -4985,7 +4986,11 @@ __init int intel_pmu_init(void)
 		name = "skylake";
 		break;
 
+	case INTEL_FAM6_ICELAKE_X:
+	case INTEL_FAM6_ICELAKE_XEON_D:
+		pmem = true;
 	case INTEL_FAM6_ICELAKE_MOBILE:
+	case INTEL_FAM6_ICELAKE_DESKTOP:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
@@ -5009,7 +5014,7 @@ __init int intel_pmu_init(void)
 		tsx_attr = icl_tsx_events_attrs;
 		x86_pmu.rtm_abort_event = X86_CONFIG(.event=0xca, .umask=0x02);
 		x86_pmu.lbr_pt_coexist = true;
-		intel_pmu_pebs_data_source_skl(false);
+		intel_pmu_pebs_data_source_skl(pmem);
 		pr_cont("Icelake events, ");
 		name = "icelake";
 		break;
