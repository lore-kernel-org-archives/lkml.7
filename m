Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E312DC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5712190F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbfKRRnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:43:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50566 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbfKRRnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:43:01 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iWl2v-000139-FI; Mon, 18 Nov 2019 18:42:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 25C2F1C19BA;
        Mon, 18 Nov 2019 18:42:41 +0100 (CET)
Date:   Mon, 18 Nov 2019 17:42:41 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Add comments for group_type and
 balancing at SD_NUMA level
Cc:     Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <efault@gmx.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1573570243-1903-1-git-send-email-vincent.guittot@linaro.org>
References: <1573570243-1903-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <157409896112.12247.8307010883378296448.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a9723389cc759c891d481de271ac73eeaa123bcb
Gitweb:        https://git.kernel.org/tip/a9723389cc759c891d481de271ac73eeaa123bcb
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 12 Nov 2019 15:50:43 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 18 Nov 2019 14:33:12 +01:00

sched/fair: Add comments for group_type and balancing at SD_NUMA level

Add comments to describe each state of goup_type and to add some details
about the load balance at NUMA level.

[ Valentin Schneider: Updates to the comments. ]
[ mingo: Other updates to the comments. ]

Reported-by: Mel Gorman <mgorman@suse.de>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Acked-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1573570243-1903-1-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2fc08e7..1f93d96 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6980,17 +6980,40 @@ static unsigned long __read_mostly max_load_balance_interval = HZ/10;
 enum fbq_type { regular, remote, all };
 
 /*
- * group_type describes the group of CPUs at the moment of the load balance.
+ * 'group_type' describes the group of CPUs at the moment of load balancing.
+ *
  * The enum is ordered by pulling priority, with the group with lowest priority
- * first so the groupe_type can be simply compared when selecting the busiest
- * group. see update_sd_pick_busiest().
+ * first so the group_type can simply be compared when selecting the busiest
+ * group. See update_sd_pick_busiest().
  */
 enum group_type {
+	/* The group has spare capacity that can be used to run more tasks.  */
 	group_has_spare = 0,
+	/*
+	 * The group is fully used and the tasks don't compete for more CPU
+	 * cycles. Nevertheless, some tasks might wait before running.
+	 */
 	group_fully_busy,
+	/*
+	 * SD_ASYM_CPUCAPACITY only: One task doesn't fit with CPU's capacity
+	 * and must be migrated to a more powerful CPU.
+	 */
 	group_misfit_task,
+	/*
+	 * SD_ASYM_PACKING only: One local CPU with higher capacity is available,
+	 * and the task should be migrated to it instead of running on the
+	 * current CPU.
+	 */
 	group_asym_packing,
+	/*
+	 * The tasks' affinity constraints previously prevented the scheduler
+	 * from balancing the load across the system.
+	 */
 	group_imbalanced,
+	/*
+	 * The CPU is overloaded and can't provide expected CPU cycles to all
+	 * tasks.
+	 */
 	group_overloaded
 };
 
@@ -8589,7 +8612,11 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 
 	/*
 	 * Try to use spare capacity of local group without overloading it or
-	 * emptying busiest
+	 * emptying busiest.
+	 * XXX Spreading tasks across NUMA nodes is not always the best policy
+	 * and special care should be taken for SD_NUMA domain level before
+	 * spreading the tasks. For now, load_balance() fully relies on
+	 * NUMA_BALANCING and fbq_classify_group/rq to override the decision.
 	 */
 	if (local->group_type == group_has_spare) {
 		if (busiest->group_type > group_fully_busy) {
