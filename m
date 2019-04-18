Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBBBC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A38720643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ANHVIQrn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390832AbfDRSbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:31:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38881 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390607AbfDRSbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:31:51 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3IIVPMP304115
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 18 Apr 2019 11:31:26 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3IIVPMP304115
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1555612286;
        bh=jBaNPlgnAgaxMD21q37fyvN6MT1ObM7Kwrm1Nbe8R2c=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ANHVIQrnOEn/0idyROSWj5tBKutaEzTdQOkwr2NMbOOCognGv3RipKtfdU9A6EBzU
         z82L2BSptPzER0pRCUivMr2RGXoWft3ojracrXR5mDi1QSuYEjzF7+ZmQ3KIJ6id8O
         uK/N8G1M/vljMdXAMilsBH0d2+u3Ng11KEQIsNDgfAvdWJgCba1AZr4n7oYQSM6qA2
         UpMB3NO2suSjV2wi6H+gfUcYKDXhNSNs5X2z8eDkb3IQ2lYeTeG/Dan22b2yjyn+sh
         ZQdJCNU7VjsuIujRZX4LiGA12VtPQFiGRwP3pAIHgz9dNVBKrYFBBoyWhbGlfqdZhk
         5KrqSZ05HibSg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3IIVP0s304112;
        Thu, 18 Apr 2019 11:31:25 -0700
Date:   Thu, 18 Apr 2019 11:31:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for YueHaibing <tipbot@zytor.com>
Message-ID: <tip-b1546edcf2aab710a5afc98d65c948a4bfac0353@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, yuehaibing@huawei.com,
        torvalds@linux-foundation.org
Reply-To: linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
          torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org,
          peterz@infradead.org, tglx@linutronix.de
In-Reply-To: <20190418144713.34332-1-yuehaibing@huawei.com>
References: <20190418144713.34332-1-yuehaibing@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/core: Make some functions static
Git-Commit-ID: b1546edcf2aab710a5afc98d65c948a4bfac0353
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

Commit-ID:  b1546edcf2aab710a5afc98d65c948a4bfac0353
Gitweb:     https://git.kernel.org/tip/b1546edcf2aab710a5afc98d65c948a4bfac0353
Author:     YueHaibing <yuehaibing@huawei.com>
AuthorDate: Thu, 18 Apr 2019 22:47:13 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 18 Apr 2019 20:28:02 +0200

sched/core: Make some functions static

Fix these sparse warnings:

  kernel/sched/core.c:6577:11: warning: symbol 'min_cfs_quota_period' was not declared. Should it be static?
  kernel/sched/core.c:6657:5: warning: symbol 'tg_set_cfs_quota' was not declared. Should it be static?
  kernel/sched/core.c:6670:6: warning: symbol 'tg_get_cfs_quota' was not declared. Should it be static?
  kernel/sched/core.c:6683:5: warning: symbol 'tg_set_cfs_period' was not declared. Should it be static?
  kernel/sched/core.c:6693:6: warning: symbol 'tg_get_cfs_period' was not declared. Should it be static?
  kernel/sched/fair.c:2596:6: warning: symbol 'task_tick_numa' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20190418144713.34332-1-yuehaibing@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/core.c | 10 +++++-----
 kernel/sched/fair.c |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f4838b78b9f9..8b64ef0d5589 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6522,7 +6522,7 @@ static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
 static DEFINE_MUTEX(cfs_constraints_mutex);
 
 const u64 max_cfs_quota_period = 1 * NSEC_PER_SEC; /* 1s */
-const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
+static const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
 
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 
@@ -6602,7 +6602,7 @@ out_unlock:
 	return ret;
 }
 
-int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
+static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 {
 	u64 quota, period;
 
@@ -6615,7 +6615,7 @@ int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 	return tg_set_cfs_bandwidth(tg, period, quota);
 }
 
-long tg_get_cfs_quota(struct task_group *tg)
+static long tg_get_cfs_quota(struct task_group *tg)
 {
 	u64 quota_us;
 
@@ -6628,7 +6628,7 @@ long tg_get_cfs_quota(struct task_group *tg)
 	return quota_us;
 }
 
-int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
+static int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
 {
 	u64 quota, period;
 
@@ -6638,7 +6638,7 @@ int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
 	return tg_set_cfs_bandwidth(tg, period, quota);
 }
 
-long tg_get_cfs_period(struct task_group *tg)
+static long tg_get_cfs_period(struct task_group *tg)
 {
 	u64 cfs_period_us;
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e5b100b6ba4e..13bafe350abf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2593,7 +2593,7 @@ out:
 /*
  * Drive the periodic memory faults..
  */
-void task_tick_numa(struct rq *rq, struct task_struct *curr)
+static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 {
 	struct callback_head *work = &curr->numa_work;
 	u64 period, now;
