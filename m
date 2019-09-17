Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01274C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB187214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404623AbfIQIGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:06:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40899 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731782AbfIQIGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:06:30 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iA8Uq-0006Ix-26; Tue, 17 Sep 2019 10:06:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 439CC1C04F3;
        Tue, 17 Sep 2019 10:05:59 +0200 (CEST)
Date:   Tue, 17 Sep 2019 08:05:59 -0000
From:   "tip-bot2 for Qian Cai" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Remove unused cfs_rq_clock_task() function
Cc:     Qian Cai <cai@lca.pw>, Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1568668775-2127-1-git-send-email-cai@lca.pw>
References: <1568668775-2127-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Message-ID: <156870755911.24167.520016299071771858.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     dac9f027b1096c5f03ca583e787aac0f852e8f78
Gitweb:        https://git.kernel.org/tip/dac9f027b1096c5f03ca583e787aac0f852e8f78
Author:        Qian Cai <cai@lca.pw>
AuthorDate:    Mon, 16 Sep 2019 17:19:35 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Sep 2019 09:55:02 +02:00

sched/fair: Remove unused cfs_rq_clock_task() function

cfs_rq_clock_task() was first introduced and used in:

  f1b17280efbd ("sched: Maintain runnable averages across throttled periods")

Over time its use has been graduately removed by the following commits:

  d31b1a66cbe0 ("sched/fair: Factorize PELT update")
  23127296889f ("sched/fair: Update scale invariance of PELT")

Today, there is no single user left, so it can be safely removed.

Found via the -Wunused-function build warning.

Signed-off-by: Qian Cai <cai@lca.pw>
Cc: Ben Segall <bsegall@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/1568668775-2127-1-git-send-email-cai@lca.pw
[ Rewrote the changelog. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bbf68..3101c66 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -749,7 +749,6 @@ void init_entity_runnable_average(struct sched_entity *se)
 	/* when this task enqueue'ed, it will contribute to its cfs_rq's load_avg */
 }
 
-static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq);
 static void attach_entity_cfs_rq(struct sched_entity *se);
 
 /*
@@ -4376,15 +4375,6 @@ static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
 	return &tg->cfs_bandwidth;
 }
 
-/* rq->task_clock normalized against any time this cfs_rq has spent throttled */
-static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq)
-{
-	if (unlikely(cfs_rq->throttle_count))
-		return cfs_rq->throttled_clock_task - cfs_rq->throttled_clock_task_time;
-
-	return rq_clock_task(rq_of(cfs_rq)) - cfs_rq->throttled_clock_task_time;
-}
-
 /* returns 0 on failure to allocate runtime */
 static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 {
@@ -4476,7 +4466,6 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 
 	cfs_rq->throttle_count--;
 	if (!cfs_rq->throttle_count) {
-		/* adjust cfs_rq_clock_task() */
 		cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
 					     cfs_rq->throttled_clock_task;
 
@@ -5080,11 +5069,6 @@ static inline bool cfs_bandwidth_used(void)
 	return false;
 }
 
-static inline u64 cfs_rq_clock_task(struct cfs_rq *cfs_rq)
-{
-	return rq_clock_task(rq_of(cfs_rq));
-}
-
 static void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec) {}
 static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq) { return false; }
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq) {}
