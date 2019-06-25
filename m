Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018B9C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB510215EA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 08:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aAEL/U11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfFYIXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 04:23:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55449 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfFYIXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 04:23:50 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5P8NYRL3527677
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 25 Jun 2019 01:23:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5P8NYRL3527677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561451014;
        bh=+14TyZ1A1BL6SImNYuUAThHNctu7tAtpKF9eH5sfqqc=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=aAEL/U11B9yh6011EXAFKi4tEJ+zIUfwDUgIWX4ZDVDL4qNQne3jzLN/R93OcJHhY
         mD/YBPGVR6gb1chq7/wxBmqJIEFy39o1rmjw1t7WEL3YKEErpdayHfswPhlcK/mglG
         +A3lf1/yIx/peU5rpyHqNDOmTXefl5BBFYLnzvWe7Pru51J/r+0fPHXBcno+eKw8Tv
         7zt6VSakyf1YaxXYIQM17dAXhfbqe6eZOQUbtbHjh7v6hqIoGEZLxPC/gBmLiqAPAe
         cDCAqvm4qxKI7xuHZ0bgZD9uu7324L7RbQYnm5y1iTx7NMdocIPW4QYbclLVBL5WsT
         doBhbKcQ9ePLg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5P8NXfI3527667;
        Tue, 25 Jun 2019 01:23:33 -0700
Date:   Tue, 25 Jun 2019 01:23:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Vincent Guittot <tipbot@zytor.com>
Message-ID: <tip-8ec59c0f5f4966f89f4e3e3cab81710c7fa959d0@git.kernel.org>
Cc:     valentin.schneider@arm.com, mingo@kernel.org, peterz@infradead.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de
Reply-To: tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
          torvalds@linux-foundation.org, vincent.guittot@linaro.org,
          viresh.kumar@linaro.org, peterz@infradead.org, mingo@kernel.org,
          valentin.schneider@arm.com
In-Reply-To: <1560783617-5827-1-git-send-email-vincent.guittot@linaro.org>
References: <1560783617-5827-1-git-send-email-vincent.guittot@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/topology: Remove unused 'sd' parameter from
 arch_scale_cpu_capacity()
Git-Commit-ID: 8ec59c0f5f4966f89f4e3e3cab81710c7fa959d0
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

Commit-ID:  8ec59c0f5f4966f89f4e3e3cab81710c7fa959d0
Gitweb:     https://git.kernel.org/tip/8ec59c0f5f4966f89f4e3e3cab81710c7fa959d0
Author:     Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate: Mon, 17 Jun 2019 17:00:17 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 24 Jun 2019 19:23:39 +0200

sched/topology: Remove unused 'sd' parameter from arch_scale_cpu_capacity()

The 'struct sched_domain *sd' parameter to arch_scale_cpu_capacity() is
unused since commit:

  765d0af19f5f ("sched/topology: Remove the ::smt_gain field from 'struct sched_domain'")

Remove it.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: gregkh@linuxfoundation.org
Cc: linux@armlinux.org.uk
Cc: quentin.perret@arm.com
Cc: rafael@kernel.org
Link: https://lkml.kernel.org/r/1560783617-5827-1-git-send-email-vincent.guittot@linaro.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/arm/kernel/topology.c       |  2 +-
 drivers/base/arch_topology.c     |  6 +++---
 include/linux/arch_topology.h    |  2 +-
 include/linux/energy_model.h     |  2 +-
 include/linux/sched/topology.h   | 14 +++-----------
 kernel/power/energy_model.c      |  2 +-
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/deadline.c          |  2 +-
 kernel/sched/fair.c              |  6 +++---
 kernel/sched/pelt.c              |  2 +-
 kernel/sched/pelt.h              |  2 +-
 kernel/sched/sched.h             |  2 +-
 kernel/sched/topology.c          |  8 ++++----
 13 files changed, 22 insertions(+), 30 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 60e375ce1ab2..d17cb1e6d679 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -169,7 +169,7 @@ static void update_cpu_capacity(unsigned int cpu)
 	topology_set_cpu_scale(cpu, cpu_capacity(cpu) / middle_capacity);
 
 	pr_info("CPU%u: update cpu_capacity %lu\n",
-		cpu, topology_get_cpu_scale(NULL, cpu));
+		cpu, topology_get_cpu_scale(cpu));
 }
 
 #else
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1739d7e1952a..9b09e31ae82f 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -43,7 +43,7 @@ static ssize_t cpu_capacity_show(struct device *dev,
 {
 	struct cpu *cpu = container_of(dev, struct cpu, dev);
 
-	return sprintf(buf, "%lu\n", topology_get_cpu_scale(NULL, cpu->dev.id));
+	return sprintf(buf, "%lu\n", topology_get_cpu_scale(cpu->dev.id));
 }
 
 static void update_topology_flags_workfn(struct work_struct *work);
@@ -116,7 +116,7 @@ void topology_normalize_cpu_scale(void)
 			/ capacity_scale;
 		topology_set_cpu_scale(cpu, capacity);
 		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
-			cpu, topology_get_cpu_scale(NULL, cpu));
+			cpu, topology_get_cpu_scale(cpu));
 	}
 }
 
@@ -185,7 +185,7 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
 
 	for_each_cpu(cpu, policy->related_cpus) {
-		raw_capacity[cpu] = topology_get_cpu_scale(NULL, cpu) *
+		raw_capacity[cpu] = topology_get_cpu_scale(cpu) *
 				    policy->cpuinfo.max_freq / 1000UL;
 		capacity_scale = max(raw_capacity[cpu], capacity_scale);
 	}
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index d9bdc1a7f4e7..1cfe05ea1d89 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -18,7 +18,7 @@ DECLARE_PER_CPU(unsigned long, cpu_scale);
 
 struct sched_domain;
 static inline
-unsigned long topology_get_cpu_scale(struct sched_domain *sd, int cpu)
+unsigned long topology_get_cpu_scale(int cpu)
 {
 	return per_cpu(cpu_scale, cpu);
 }
diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index aa027f7bcb3e..73f8c3cb9588 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -89,7 +89,7 @@ static inline unsigned long em_pd_energy(struct em_perf_domain *pd,
 	 * like schedutil.
 	 */
 	cpu = cpumask_first(to_cpumask(pd->cpus));
-	scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
+	scale_cpu = arch_scale_cpu_capacity(cpu);
 	cs = &pd->table[pd->nr_cap_states - 1];
 	freq = map_util_freq(max_util, cs->frequency, scale_cpu);
 
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 53afbe07354a..e445d3767cdd 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -196,14 +196,6 @@ extern void set_sched_topology(struct sched_domain_topology_level *tl);
 # define SD_INIT_NAME(type)
 #endif
 
-#ifndef arch_scale_cpu_capacity
-static __always_inline
-unsigned long arch_scale_cpu_capacity(struct sched_domain *sd, int cpu)
-{
-	return SCHED_CAPACITY_SCALE;
-}
-#endif
-
 #else /* CONFIG_SMP */
 
 struct sched_domain_attr;
@@ -219,16 +211,16 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
 	return true;
 }
 
+#endif	/* !CONFIG_SMP */
+
 #ifndef arch_scale_cpu_capacity
 static __always_inline
-unsigned long arch_scale_cpu_capacity(void __always_unused *sd, int cpu)
+unsigned long arch_scale_cpu_capacity(int cpu)
 {
 	return SCHED_CAPACITY_SCALE;
 }
 #endif
 
-#endif	/* !CONFIG_SMP */
-
 static inline int task_node(const struct task_struct *p)
 {
 	return cpu_to_node(task_cpu(p));
diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index 7d66ee68aaaf..0a9326f5f421 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -223,7 +223,7 @@ int em_register_perf_domain(cpumask_t *span, unsigned int nr_states,
 		 * All CPUs of a domain must have the same micro-architecture
 		 * since they all share the same table.
 		 */
-		cap = arch_scale_cpu_capacity(NULL, cpu);
+		cap = arch_scale_cpu_capacity(cpu);
 		if (prev_cap && prev_cap != cap) {
 			pr_err("CPUs of %*pbl must have the same capacity\n",
 							cpumask_pr_args(span));
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 962cf343f798..7c4ce69067c4 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -276,7 +276,7 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 	unsigned long util = cpu_util_cfs(rq);
-	unsigned long max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
+	unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
 
 	sg_cpu->max = max;
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c1ef30861068..8b5bb2ac16e2 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1195,7 +1195,7 @@ static void update_curr_dl(struct rq *rq)
 						 &curr->dl);
 	} else {
 		unsigned long scale_freq = arch_scale_freq_capacity(cpu);
-		unsigned long scale_cpu = arch_scale_cpu_capacity(NULL, cpu);
+		unsigned long scale_cpu = arch_scale_cpu_capacity(cpu);
 
 		scaled_delta_exec = cap_scale(delta_exec, scale_freq);
 		scaled_delta_exec = cap_scale(scaled_delta_exec, scale_cpu);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3c11dcdedcbc..4f8754157763 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -764,7 +764,7 @@ void post_init_entity_util_avg(struct task_struct *p)
 	struct sched_entity *se = &p->se;
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	struct sched_avg *sa = &se->avg;
-	long cpu_scale = arch_scale_cpu_capacity(NULL, cpu_of(rq_of(cfs_rq)));
+	long cpu_scale = arch_scale_cpu_capacity(cpu_of(rq_of(cfs_rq)));
 	long cap = (long)(cpu_scale - cfs_rq->avg.util_avg) / 2;
 
 	if (cap > 0) {
@@ -7646,7 +7646,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 static unsigned long scale_rt_capacity(struct sched_domain *sd, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long max = arch_scale_cpu_capacity(sd, cpu);
+	unsigned long max = arch_scale_cpu_capacity(cpu);
 	unsigned long used, free;
 	unsigned long irq;
 
@@ -7671,7 +7671,7 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 	unsigned long capacity = scale_rt_capacity(sd, cpu);
 	struct sched_group *sdg = sd->groups;
 
-	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(sd, cpu);
+	cpu_rq(cpu)->cpu_capacity_orig = arch_scale_cpu_capacity(cpu);
 
 	if (!capacity)
 		capacity = 1;
diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index befce29bd882..42ea66b07b1d 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -366,7 +366,7 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 	 * reflect the real amount of computation
 	 */
 	running = cap_scale(running, arch_scale_freq_capacity(cpu_of(rq)));
-	running = cap_scale(running, arch_scale_cpu_capacity(NULL, cpu_of(rq)));
+	running = cap_scale(running, arch_scale_cpu_capacity(cpu_of(rq)));
 
 	/*
 	 * We know the time that has been used by interrupt since last update
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 7489d5f56960..afff644da065 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -79,7 +79,7 @@ static inline void update_rq_clock_pelt(struct rq *rq, s64 delta)
 	 * Scale the elapsed time to reflect the real amount of
 	 * computation
 	 */
-	delta = cap_scale(delta, arch_scale_cpu_capacity(NULL, cpu_of(rq)));
+	delta = cap_scale(delta, arch_scale_cpu_capacity(cpu_of(rq)));
 	delta = cap_scale(delta, arch_scale_freq_capacity(cpu_of(rq)));
 
 	rq->clock_pelt += delta;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b08dee29ef5e..e58ab597ec88 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2248,7 +2248,7 @@ unsigned long schedutil_freq_util(int cpu, unsigned long util_cfs,
 
 static inline unsigned long schedutil_energy_util(int cpu, unsigned long cfs)
 {
-	unsigned long max = arch_scale_cpu_capacity(NULL, cpu);
+	unsigned long max = arch_scale_cpu_capacity(cpu);
 
 	return schedutil_freq_util(cpu, cfs, max, ENERGY_UTIL);
 }
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 63184cf0d0d7..f751ce0b783e 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1874,10 +1874,10 @@ static struct sched_domain_topology_level
 	unsigned long cap;
 
 	/* Is there any asymmetry? */
-	cap = arch_scale_cpu_capacity(NULL, cpumask_first(cpu_map));
+	cap = arch_scale_cpu_capacity(cpumask_first(cpu_map));
 
 	for_each_cpu(i, cpu_map) {
-		if (arch_scale_cpu_capacity(NULL, i) != cap) {
+		if (arch_scale_cpu_capacity(i) != cap) {
 			asym = true;
 			break;
 		}
@@ -1892,7 +1892,7 @@ static struct sched_domain_topology_level
 	 * to everyone.
 	 */
 	for_each_cpu(i, cpu_map) {
-		unsigned long max_capacity = arch_scale_cpu_capacity(NULL, i);
+		unsigned long max_capacity = arch_scale_cpu_capacity(i);
 		int tl_id = 0;
 
 		for_each_sd_topology(tl) {
@@ -1902,7 +1902,7 @@ static struct sched_domain_topology_level
 			for_each_cpu_and(j, tl->mask(i), cpu_map) {
 				unsigned long capacity;
 
-				capacity = arch_scale_cpu_capacity(NULL, j);
+				capacity = arch_scale_cpu_capacity(j);
 
 				if (capacity <= max_capacity)
 					continue;
