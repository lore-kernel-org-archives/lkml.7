Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B66C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC3320675
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BegBvfPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbfEWJfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:35:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33325 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfEWJfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:35:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4N9ZWDV4043417
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 23 May 2019 02:35:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4N9ZWDV4043417
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1558604133;
        bh=e13fdUYn6AtPPKKJcVcv/6VhQZ3BDCrv6E5sGnhZ3eI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BegBvfPfaP/YiaLMB4P9/5EqroWFTgP8JdvWH0dTP7oRSVyyK170h3V3dHL9yVBEe
         W1Asrrd4nlEut9fCTD5LGOyYmTnltuYBAf9FMWjBWRHcGtqkGK299fQ1XzZsqhgtWH
         Wrn0alpJwWTzRqBkS50G4sFwQl+howK5R9R45nnLGSPtpxWI+0zdStK+sju38939qb
         HMwRA8EHZV8hOpALvF+yBdT77mw989u5xGLDIO6EEO9IowwxtkogMArqFUwd3+IPxw
         SJSwNJGkEABBl/DRCfKiq3fFwJ2lLhSQugJNe5yjBcTP2ZArWDB9qov3PZrIkS7r7F
         RM2XL2wc5t1/w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4N9ZWdA4043414;
        Thu, 23 May 2019 02:35:32 -0700
Date:   Thu, 23 May 2019 02:35:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-eb876fbc248e6eb4773a5bc80d205ff7262b1bb5@git.kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        len.brown@intel.com, peterz@infradead.org,
        kan.liang@linux.intel.com, mingo@kernel.org, hpa@zytor.com
Reply-To: peterz@infradead.org, kan.liang@linux.intel.com,
          mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, len.brown@intel.com
In-Reply-To: <0ddb97e121397d37933233da303556141814fa47.1557769318.git.len.brown@intel.com>
References: <0ddb97e121397d37933233da303556141814fa47.1557769318.git.len.brown@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/topology] perf/x86/intel/rapl: Cosmetic rename internal
 variables in response to multi-die/pkg support
Git-Commit-ID: eb876fbc248e6eb4773a5bc80d205ff7262b1bb5
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

Commit-ID:  eb876fbc248e6eb4773a5bc80d205ff7262b1bb5
Gitweb:     https://git.kernel.org/tip/eb876fbc248e6eb4773a5bc80d205ff7262b1bb5
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Mon, 13 May 2019 13:59:03 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 23 May 2019 10:08:37 +0200

perf/x86/intel/rapl: Cosmetic rename internal variables in response to multi-die/pkg support

Syntax update only -- no logical or functional change.

In response to the new multi-die/package changes, update variable names to
use "die" terminology, instead of "pkg".

For previous platforms which doesn't have multi-die, "die" is identical as
"pkg".

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/0ddb97e121397d37933233da303556141814fa47.1557769318.git.len.brown@intel.com

---
 arch/x86/events/intel/rapl.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 6f5331271563..3992b0e65a55 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -148,7 +148,7 @@ struct rapl_pmu {
 
 struct rapl_pmus {
 	struct pmu		pmu;
-	unsigned int		maxpkg;
+	unsigned int		maxdie;
 	struct rapl_pmu		*pmus[];
 };
 
@@ -161,13 +161,13 @@ static u64 rapl_timer_ms;
 
 static inline struct rapl_pmu *cpu_to_rapl_pmu(unsigned int cpu)
 {
-	unsigned int pkgid = topology_logical_die_id(cpu);
+	unsigned int dieid = topology_logical_die_id(cpu);
 
 	/*
 	 * The unsigned check also catches the '-1' return value for non
 	 * existent mappings in the topology map.
 	 */
-	return pkgid < rapl_pmus->maxpkg ? rapl_pmus->pmus[pkgid] : NULL;
+	return dieid < rapl_pmus->maxdie ? rapl_pmus->pmus[dieid] : NULL;
 }
 
 static inline u64 rapl_read_counter(struct perf_event *event)
@@ -668,22 +668,22 @@ static void cleanup_rapl_pmus(void)
 {
 	int i;
 
-	for (i = 0; i < rapl_pmus->maxpkg; i++)
+	for (i = 0; i < rapl_pmus->maxdie; i++)
 		kfree(rapl_pmus->pmus[i]);
 	kfree(rapl_pmus);
 }
 
 static int __init init_rapl_pmus(void)
 {
-	int maxpkg = topology_max_packages() * topology_max_die_per_package();
+	int maxdie = topology_max_packages() * topology_max_die_per_package();
 	size_t size;
 
-	size = sizeof(*rapl_pmus) + maxpkg * sizeof(struct rapl_pmu *);
+	size = sizeof(*rapl_pmus) + maxdie * sizeof(struct rapl_pmu *);
 	rapl_pmus = kzalloc(size, GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
 
-	rapl_pmus->maxpkg		= maxpkg;
+	rapl_pmus->maxdie		= maxdie;
 	rapl_pmus->pmu.attr_groups	= rapl_attr_groups;
 	rapl_pmus->pmu.task_ctx_nr	= perf_invalid_context;
 	rapl_pmus->pmu.event_init	= rapl_pmu_event_init;
