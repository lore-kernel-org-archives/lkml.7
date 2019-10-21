Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51470CA9EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2567B20873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:13:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfJUJNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:13:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33958 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbfJUJNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:13:22 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMTk7-0005Jh-Ir; Mon, 21 Oct 2019 11:12:47 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2FD461C0494;
        Mon, 21 Oct 2019 11:12:44 +0200 (CEST)
Date:   Mon, 21 Oct 2019 09:12:43 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Rename sg_lb_stats::sum_nr_running to
 sum_h_nr_running
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Mike Galbraith <efault@gmx.de>,
        Morten.Rasmussen@arm.com, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>, hdanton@sina.com,
        parth@linux.ibm.com, pauld@redhat.com, quentin.perret@arm.com,
        srikar@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1571405198-27570-3-git-send-email-vincent.guittot@linaro.org>
References: <1571405198-27570-3-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <157164916399.29376.9524039247384153217.tip-bot2@tip-bot2>
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

Commit-ID:     a34983470301018324f0110791da452fee1318c2
Gitweb:        https://git.kernel.org/tip/a34983470301018324f0110791da452fee1318c2
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Fri, 18 Oct 2019 15:26:29 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 21 Oct 2019 09:40:53 +02:00

sched/fair: Rename sg_lb_stats::sum_nr_running to sum_h_nr_running

Rename sum_nr_running to sum_h_nr_running because it effectively tracks
cfs->h_nr_running so we can use sum_nr_running to track rq->nr_running
when needed.

There are no functional changes.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Acked-by: Rik van Riel <riel@surriel.com>
Cc: Ben Segall <bsegall@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Morten.Rasmussen@arm.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: hdanton@sina.com
Cc: parth@linux.ibm.com
Cc: pauld@redhat.com
Cc: quentin.perret@arm.com
Cc: srikar@linux.vnet.ibm.com
Link: https://lkml.kernel.org/r/1571405198-27570-3-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5ce0f71..ad8f16a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7660,7 +7660,7 @@ struct sg_lb_stats {
 	unsigned long load_per_task;
 	unsigned long group_capacity;
 	unsigned long group_util; /* Total utilization of the group */
-	unsigned int sum_nr_running; /* Nr tasks running in the group */
+	unsigned int sum_h_nr_running; /* Nr of CFS tasks running in the group */
 	unsigned int idle_cpus;
 	unsigned int group_weight;
 	enum group_type group_type;
@@ -7705,7 +7705,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 		.total_capacity = 0UL,
 		.busiest_stat = {
 			.avg_load = 0UL,
-			.sum_nr_running = 0,
+			.sum_h_nr_running = 0,
 			.group_type = group_other,
 		},
 	};
@@ -7896,7 +7896,7 @@ static inline int sg_imbalanced(struct sched_group *group)
 static inline bool
 group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_nr_running < sgs->group_weight)
+	if (sgs->sum_h_nr_running < sgs->group_weight)
 		return true;
 
 	if ((sgs->group_capacity * 100) >
@@ -7917,7 +7917,7 @@ group_has_capacity(struct lb_env *env, struct sg_lb_stats *sgs)
 static inline bool
 group_is_overloaded(struct lb_env *env, struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_nr_running <= sgs->group_weight)
+	if (sgs->sum_h_nr_running <= sgs->group_weight)
 		return false;
 
 	if ((sgs->group_capacity * 100) <
@@ -8009,7 +8009,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 		sgs->group_load += cpu_runnable_load(rq);
 		sgs->group_util += cpu_util(i);
-		sgs->sum_nr_running += rq->cfs.h_nr_running;
+		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
 
 		nr_running = rq->nr_running;
 		if (nr_running > 1)
@@ -8039,8 +8039,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 	sgs->group_capacity = group->sgc->capacity;
 	sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) / sgs->group_capacity;
 
-	if (sgs->sum_nr_running)
-		sgs->load_per_task = sgs->group_load / sgs->sum_nr_running;
+	if (sgs->sum_h_nr_running)
+		sgs->load_per_task = sgs->group_load / sgs->sum_h_nr_running;
 
 	sgs->group_weight = group->group_weight;
 
@@ -8097,7 +8097,7 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * capable CPUs may harm throughput. Maximize throughput,
 	 * power/energy consequences are not considered.
 	 */
-	if (sgs->sum_nr_running <= sgs->group_weight &&
+	if (sgs->sum_h_nr_running <= sgs->group_weight &&
 	    group_smaller_min_cpu_capacity(sds->local, sg))
 		return false;
 
@@ -8128,7 +8128,7 @@ asym_packing:
 	 * perform better since they share less core resources.  Hence when we
 	 * have idle threads, we want them to be the higher ones.
 	 */
-	if (sgs->sum_nr_running &&
+	if (sgs->sum_h_nr_running &&
 	    sched_asym_prefer(env->dst_cpu, sg->asym_prefer_cpu)) {
 		sgs->group_asym_packing = 1;
 		if (!sds->busiest)
@@ -8146,9 +8146,9 @@ asym_packing:
 #ifdef CONFIG_NUMA_BALANCING
 static inline enum fbq_type fbq_classify_group(struct sg_lb_stats *sgs)
 {
-	if (sgs->sum_nr_running > sgs->nr_numa_running)
+	if (sgs->sum_h_nr_running > sgs->nr_numa_running)
 		return regular;
-	if (sgs->sum_nr_running > sgs->nr_preferred_running)
+	if (sgs->sum_h_nr_running > sgs->nr_preferred_running)
 		return remote;
 	return all;
 }
@@ -8223,7 +8223,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 		 */
 		if (prefer_sibling && sds->local &&
 		    group_has_capacity(env, local) &&
-		    (sgs->sum_nr_running > local->sum_nr_running + 1)) {
+		    (sgs->sum_h_nr_running > local->sum_h_nr_running + 1)) {
 			sgs->group_no_capacity = 1;
 			sgs->group_type = group_classify(sg, sgs);
 		}
@@ -8235,7 +8235,7 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 
 next_group:
 		/* Now, start updating sd_lb_stats */
-		sds->total_running += sgs->sum_nr_running;
+		sds->total_running += sgs->sum_h_nr_running;
 		sds->total_load += sgs->group_load;
 		sds->total_capacity += sgs->group_capacity;
 
@@ -8289,7 +8289,7 @@ void fix_small_imbalance(struct lb_env *env, struct sd_lb_stats *sds)
 	local = &sds->local_stat;
 	busiest = &sds->busiest_stat;
 
-	if (!local->sum_nr_running)
+	if (!local->sum_h_nr_running)
 		local->load_per_task = cpu_avg_load_per_task(env->dst_cpu);
 	else if (busiest->load_per_task > local->load_per_task)
 		imbn = 1;
@@ -8387,7 +8387,7 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	 */
 	if (busiest->group_type == group_overloaded &&
 	    local->group_type   == group_overloaded) {
-		load_above_capacity = busiest->sum_nr_running * SCHED_CAPACITY_SCALE;
+		load_above_capacity = busiest->sum_h_nr_running * SCHED_CAPACITY_SCALE;
 		if (load_above_capacity > busiest->group_capacity) {
 			load_above_capacity -= busiest->group_capacity;
 			load_above_capacity *= scale_load_down(NICE_0_LOAD);
@@ -8468,7 +8468,7 @@ static struct sched_group *find_busiest_group(struct lb_env *env)
 		goto force_balance;
 
 	/* There is no busy sibling group to pull tasks from */
-	if (!sds.busiest || busiest->sum_nr_running == 0)
+	if (!sds.busiest || busiest->sum_h_nr_running == 0)
 		goto out_balanced;
 
 	/* XXX broken for overlapping NUMA groups */
