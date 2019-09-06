Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB89C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A9BD2082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395341AbfIFSaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 14:30:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:14040 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730881AbfIFSaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:30:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Sep 2019 11:30:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,473,1559545200"; 
   d="scan'208";a="199572909"
Received: from schen9-desk.jf.intel.com (HELO [10.54.74.162]) ([10.54.74.162])
  by fmsmga001.fm.intel.com with ESMTP; 06 Sep 2019 11:30:21 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Dario Faggioli <dfaggioli@suse.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>
Cc:     Aaron Lu <aaron.lu@linux.alibaba.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20190612163345.GB26997@sinkpad>
 <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
 <20190613032246.GA17752@sinkpad>
 <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad> <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu> <20190726152101.GA27884@sinkpad>
 <7dc86e3c-aa3f-905f-3745-01181a3b0dac@linux.intel.com>
 <20190802153715.GA18075@sinkpad>
 <eec72c2d533b7600c63de3c8001cc6ab9e915afe.camel@suse.com>
 <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual; keydata=
 mQINBE6ONugBEAC1c8laQ2QrezbYFetwrzD0v8rOqanj5X1jkySQr3hm/rqVcDJudcfdSMv0
 BNCCjt2dofFxVfRL0G8eQR4qoSgzDGDzoFva3NjTJ/34TlK9MMouLY7X5x3sXdZtrV4zhKGv
 3Rt2osfARdH3QDoTUHujhQxlcPk7cwjTXe4o3aHIFbcIBUmxhqPaz3AMfdCqbhd7uWe9MAZX
 7M9vk6PboyO4PgZRAs5lWRoD4ZfROtSViX49KEkO7BDClacVsODITpiaWtZVDxkYUX/D9OxG
 AkxmqrCxZxxZHDQos1SnS08aKD0QITm/LWQtwx1y0P4GGMXRlIAQE4rK69BDvzSaLB45ppOw
 AO7kw8aR3eu/sW8p016dx34bUFFTwbILJFvazpvRImdjmZGcTcvRd8QgmhNV5INyGwtfA8sn
 L4V13aZNZA9eWd+iuB8qZfoFiyAeHNWzLX/Moi8hB7LxFuEGnvbxYByRS83jsxjH2Bd49bTi
 XOsAY/YyGj6gl8KkjSbKOkj0IRy28nLisFdGBvgeQrvaLaA06VexptmrLjp1Qtyesw6zIJeP
 oHUImJltjPjFvyfkuIPfVIB87kukpB78bhSRA5mC365LsLRl+nrX7SauEo8b7MX0qbW9pg0f
 wsiyCCK0ioTTm4IWL2wiDB7PeiJSsViBORNKoxA093B42BWFJQARAQABtDRUaW0gQ2hlbiAo
 d29yayByZWxhdGVkKSA8dGltLmMuY2hlbkBsaW51eC5pbnRlbC5jb20+iQI+BBMBAgAoAhsD
 BgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCXFIuxAUJEYZe0wAKCRCiZ7WKota4STH3EACW
 1jBRzdzEd5QeTQWrTtB0Dxs5cC8/P7gEYlYQCr3Dod8fG7UcPbY7wlZXc3vr7+A47/bSTVc0
 DhUAUwJT+VBMIpKdYUbvfjmgicL9mOYW73/PHTO38BsMyoeOtuZlyoUl3yoxWmIqD4S1xV04
 q5qKyTakghFa+1ZlGTAIqjIzixY0E6309spVTHoImJTkXNdDQSF0AxjW0YNejt52rkGXXSoi
 IgYLRb3mLJE/k1KziYtXbkgQRYssty3n731prN5XrupcS4AiZIQl6+uG7nN2DGn9ozy2dgTi
 smPAOFH7PKJwj8UU8HUYtX24mQA6LKRNmOgB290PvrIy89FsBot/xKT2kpSlk20Ftmke7KCa
 65br/ExDzfaBKLynztcF8o72DXuJ4nS2IxfT/Zmkekvvx/s9R4kyPyebJ5IA/CH2Ez6kXIP+
 q0QVS25WF21vOtK52buUgt4SeRbqSpTZc8bpBBpWQcmeJqleo19WzITojpt0JvdVNC/1H7mF
 4l7og76MYSTCqIKcLzvKFeJSie50PM3IOPp4U2czSrmZURlTO0o1TRAa7Z5v/j8KxtSJKTgD
 lYKhR0MTIaNw3z5LPWCCYCmYfcwCsIa2vd3aZr3/Ao31ZnBuF4K2LCkZR7RQgLu+y5Tr8P7c
 e82t/AhTZrzQowzP0Vl6NQo8N6C2fcwjSrkCDQROjjboARAAx+LxKhznLH0RFvuBEGTcntrC
 3S0tpYmVsuWbdWr2ZL9VqZmXh6UWb0K7w7OpPNW1FiaWtVLnG1nuMmBJhE5jpYsi+yU8sbMA
 5BEiQn2hUo0k5eww5/oiyNI9H7vql9h628JhYd9T1CcDMghTNOKfCPNGzQ8Js33cFnszqL4I
 N9jh+qdg5FnMHs/+oBNtlvNjD1dQdM6gm8WLhFttXNPn7nRUPuLQxTqbuoPgoTmxUxR3/M5A
 KDjntKEdYZziBYfQJkvfLJdnRZnuHvXhO2EU1/7bAhdz7nULZktw9j1Sp9zRYfKRnQdIvXXa
 jHkOn3N41n0zjoKV1J1KpAH3UcVfOmnTj+u6iVMW5dkxLo07CddJDaayXtCBSmmd90OG0Odx
 cq9VaIu/DOQJ8OZU3JORiuuq40jlFsF1fy7nZSvQFsJlSmHkb+cDMZDc1yk0ko65girmNjMF
 hsAdVYfVsqS1TJrnengBgbPgesYO5eY0Tm3+0pa07EkONsxnzyWJDn4fh/eA6IEUo2JrOrex
 O6cRBNv9dwrUfJbMgzFeKdoyq/Zwe9QmdStkFpoh9036iWsj6Nt58NhXP8WDHOfBg9o86z9O
 VMZMC2Q0r6pGm7L0yHmPiixrxWdW0dGKvTHu/DH/ORUrjBYYeMsCc4jWoUt4Xq49LX98KDGN
 dhkZDGwKnAUAEQEAAYkCJQQYAQIADwIbDAUCXFIulQUJEYZenwAKCRCiZ7WKota4SYqUEACj
 P/GMnWbaG6s4TPM5Dg6lkiSjFLWWJi74m34I19vaX2CAJDxPXoTU6ya8KwNgXU4yhVq7TMId
 keQGTIw/fnCv3RLNRcTAapLarxwDPRzzq2snkZKIeNh+WcwilFjTpTRASRMRy9ehKYMq6Zh7
 PXXULzxblhF60dsvi7CuRsyiYprJg0h2iZVJbCIjhumCrsLnZ531SbZpnWz6OJM9Y16+HILp
 iZ77miSE87+xNa5Ye1W1ASRNnTd9ftWoTgLezi0/MeZVQ4Qz2Shk0MIOu56UxBb0asIaOgRj
 B5RGfDpbHfjy3Ja5WBDWgUQGgLd2b5B6MVruiFjpYK5WwDGPsj0nAOoENByJ+Oa6vvP2Olkl
 gQzSV2zm9vjgWeWx9H+X0eq40U+ounxTLJYNoJLK3jSkguwdXOfL2/Bvj2IyU35EOC5sgO6h
 VRt3kA/JPvZK+6MDxXmm6R8OyohR8uM/9NCb9aDw/DnLEWcFPHfzzFFn0idp7zD5SNgAXHzV
 PFY6UGIm86OuPZuSG31R0AU5zvcmWCeIvhxl5ZNfmZtv5h8TgmfGAgF4PSD0x/Bq4qobcfaL
 ugWG5FwiybPzu2H9ZLGoaRwRmCnzblJG0pRzNaC/F+0hNf63F1iSXzIlncHZ3By15bnt5QDk
 l50q2K/r651xphs7CGEdKi1nU0YJVbQxJQ==
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <fab8eabb-1cfa-9bf6-02af-3afdff3f955d@linux.intel.com>
Date:   Fri, 6 Sep 2019 11:30:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <69cd9bca-da28-1d35-3913-1efefe0c1c22@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/19 10:10 AM, Tim Chen wrote:

> 3) Load balancing between CPU cores
> -----------------------------------
> Say if one CPU core's sibling threads get forced idled
> a lot as it has mostly incompatible tasks between the siblings,
> moving the incompatible load to other cores and pulling
> compatible load to the core could help CPU utilization.
> 
> So just considering the load of a task is not enough during
> load balancing, task compatibility also needs to be considered.
> Peter has put in mechanisms to balance compatible tasks between
> CPU thread siblings, but not across cores.
> 
> Status:
> I have not seen patches on this issue.  This issue could lead to
> large variance in workload performance based on your luck
> in placing the workload among the cores.
> 

I've made an attempt in the following two patches to address
the load balancing of mismatched load between the siblings.

It is applied on top of Aaron's patches:
- sched: Fix incorrect rq tagged as forced idle
- wrapper for cfs_rq->min_vruntime
  https://lore.kernel.org/lkml/20190725143127.GB992@aaronlu/
- core vruntime comparison
  https://lore.kernel.org/lkml/20190725143248.GC992@aaronlu/

I will love Julien, Aaron and others to try it out.  Suggestions
to tune it is welcomed.

Tim

---

From c7b91fb26d787d020f0795c3fbec82914889dc67 Mon Sep 17 00:00:00 2001
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Wed, 21 Aug 2019 15:48:15 -0700
Subject: [PATCH 1/2] sched: scan core sched load mismatch

Calculate the mismatched load imbalance on a core when
running the core scheduler when we are updating the
load balance statistics.  This will guide the load
balancer later to move load to another CPU that can
reduce the mismatched load.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 150 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 149 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 730c9359e9c9..b3d6a6482553 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7507,6 +7507,9 @@ static inline int migrate_degrades_locality(struct task_struct *p,
 }
 #endif
 
+static inline s64 core_sched_imbalance_improvement(int src_cpu, int dst_cpu,
+					      struct task_struct *p);
+
 /*
  * can_migrate_task - may task p from runqueue rq be migrated to this_cpu?
  */
@@ -7970,6 +7973,11 @@ struct sg_lb_stats {
 	unsigned int nr_numa_running;
 	unsigned int nr_preferred_running;
 #endif
+#ifdef CONFIG_SCHED_CORE
+	int			imbl_cpu;
+	struct task_group	*imbl_tg;
+	s64			imbl_load;
+#endif
 };
 
 /*
@@ -8314,6 +8322,145 @@ static bool update_nohz_stats(struct rq *rq, bool force)
 #endif
 }
 
+#ifdef CONFIG_SCHED_CORE
+static inline int cpu_sibling(int cpu)
+{
+	int i;
+
+	for_each_cpu(i, cpu_smt_mask(cpu)) {
+		if (i == cpu)
+			continue;
+		return i;
+	}
+	return -1;
+}
+
+static inline s64 core_sched_imbalance_delta(int src_cpu, int dst_cpu,
+			int src_sibling, int dst_sibling,
+			struct task_group *tg, u64 task_load)
+{
+	struct sched_entity *se, *se_sibling, *dst_se, *dst_se_sibling;
+	s64 excess, deficit, old_mismatch, new_mismatch;
+
+	if (src_cpu == dst_cpu)
+		return -1;
+
+	/* XXX SMT4 will require additional logic */
+
+	se = tg->se[src_cpu];
+	se_sibling = tg->se[src_sibling];
+
+	excess = se->avg.load_avg - se_sibling->avg.load_avg;
+	if (src_sibling == dst_cpu) {
+		old_mismatch = abs(excess);
+		new_mismatch = abs(excess - 2*task_load);
+		return old_mismatch - new_mismatch;
+	}
+
+	dst_se = tg->se[dst_cpu];
+	dst_se_sibling = tg->se[dst_sibling];
+	deficit = dst_se->avg.load_avg - dst_se_sibling->avg.load_avg;
+
+	old_mismatch = abs(excess) + abs(deficit);
+	new_mismatch = abs(excess - (s64) task_load) +
+		       abs(deficit + (s64) task_load);
+
+	if (excess > 0 && deficit < 0)
+		return old_mismatch - new_mismatch;
+	else
+		/* no mismatch improvement */
+		return -1;
+}
+
+static inline s64 core_sched_imbalance_improvement(int src_cpu, int dst_cpu,
+					      struct task_struct *p)
+{
+	int src_sibling, dst_sibling;
+	unsigned long task_load = task_h_load(p);
+	struct task_group *tg;
+
+	if (!p->se.parent)
+		return 0;
+
+	tg = p->se.parent->cfs_rq->tg;
+	if (!tg->tagged)
+		return 0;
+
+	/* XXX SMT4 will require additional logic */
+	src_sibling = cpu_sibling(src_cpu);
+	dst_sibling = cpu_sibling(dst_cpu);
+
+	if (src_sibling == -1 || dst_sibling == -1)
+		return 0;
+
+	return core_sched_imbalance_delta(src_cpu, dst_cpu,
+					  src_sibling, dst_sibling,
+					  tg, task_load);
+}
+
+static inline void core_sched_imbalance_scan(struct sg_lb_stats *sgs,
+					     int src_cpu,
+					     int dst_cpu)
+{
+	struct rq *rq;
+	struct cfs_rq *cfs_rq, *pos;
+	struct task_group *tg;
+	s64 mismatch;
+	int src_sibling, dst_sibling;
+	u64 src_avg_load_task;
+
+	if (!sched_core_enabled(cpu_rq(src_cpu)) ||
+	    !sched_core_enabled(cpu_rq(dst_cpu)) ||
+	    src_cpu == dst_cpu)
+		return;
+
+	rq = cpu_rq(src_cpu);
+
+	src_sibling = cpu_sibling(src_cpu);
+	dst_sibling = cpu_sibling(dst_cpu);
+
+	if (src_sibling == -1 || dst_sibling == -1)
+		return;
+
+	src_avg_load_task = cpu_avg_load_per_task(src_cpu);
+
+	if (src_avg_load_task == 0)
+		return;
+
+	/*
+	 * Imbalance in tagged task group's load causes forced
+	 * idle time in sibling, that will be counted as mismatched load
+	 * on the forced idled cpu.  Record the source cpu in the sched
+	 * group causing the largest mismatched load.
+	 */
+	for_each_leaf_cfs_rq_safe(rq, cfs_rq, pos) {
+
+		tg = cfs_rq->tg;
+		if (!tg->tagged)
+			continue;
+
+		mismatch = core_sched_imbalance_delta(src_cpu, dst_cpu,
+						      src_sibling, dst_sibling,
+						      tg, src_avg_load_task);
+
+		if (mismatch > sgs->imbl_load &&
+		    mismatch > src_avg_load_task) {
+			sgs->imbl_load = mismatch;
+			sgs->imbl_tg = tg;
+			sgs->imbl_cpu = src_cpu;
+		}
+	}
+}
+
+#else
+#define core_sched_imbalance_scan(sgs, src_cpu, dst_cpu)
+static inline s64 core_sched_imbalance_improvement(int src_cpu, int dst_cpu,
+					      struct task_struct *p)
+{
+	return 0;
+}
+#endif /* CONFIG_SCHED_CORE */
+
 /**
  * update_sg_lb_stats - Update sched_group's statistics for load balancing.
  * @env: The load balancing environment.
@@ -8345,7 +8492,8 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		else
 			load = source_load(i, load_idx);
 
-		sgs->group_load += load;
+		core_sched_imbalance_scan(sgs, i, env->dst_cpu);
+
 		sgs->group_util += cpu_util(i);
 		sgs->sum_nr_running += rq->cfs.h_nr_running;
 
-- 
2.20.1


From a11084f84de9c174f36cf2701ba5bbe1546e45f5 Mon Sep 17 00:00:00 2001
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Wed, 28 Aug 2019 11:22:43 -0700
Subject: [PATCH 2/2] sched: load balance core imbalanced load

If moving mismatched core scheduling load can reduce load imbalance
more than regular load balancing, move the mismatched load instead.

On regular load balancing, also skip moving a task that could increase
load mismatch.

Move only one mismatched task at a time to reduce load disturbance.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b3d6a6482553..69939c977797 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7412,6 +7412,11 @@ struct lb_env {
 	enum fbq_type		fbq_type;
 	enum group_type		src_grp_type;
 	struct list_head	tasks;
+#ifdef CONFIG_SCHED_CORE
+	int			imbl_cpu;
+	struct task_group	*imbl_tg;
+	s64			imbl_load;
+#endif
 };
 
 /*
@@ -7560,6 +7565,12 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 		return 0;
 	}
 
+#ifdef CONFIG_SCHED_CORE
+	/* Don't migrate if we increase core imbalance */
+	if (core_sched_imbalance_improvement(env->src_cpu, env->dst_cpu, p) < 0)
+		return 0;
+#endif
+
 	/* Record that we found atleast one task that could run on dst_cpu */
 	env->flags &= ~LBF_ALL_PINNED;
 
@@ -8533,6 +8544,14 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 	sgs->group_no_capacity = group_is_overloaded(env, sgs);
 	sgs->group_type = group_classify(group, sgs);
+
+#ifdef CONFIG_SCHED_CORE
+	if (sgs->imbl_load > env->imbl_load) {
+		env->imbl_cpu = sgs->imbl_cpu;
+		env->imbl_tg = sgs->imbl_tg;
+		env->imbl_load = sgs->imbl_load;
+	}
+#endif
 }
 
 /**
@@ -9066,6 +9085,15 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 	unsigned long busiest_load = 0, busiest_capacity = 1;
 	int i;
 
+#ifdef CONFIG_SCHED_CORE
+	if (env->imbl_load > env->imbalance) {
+		env->imbalance = cpu_avg_load_per_task(env->imbl_cpu);
+		return cpu_rq(env->imbl_cpu);
+	} else {
+		env->imbl_load = 0;
+	}
+#endif
+
 	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
 		unsigned long capacity, wl;
 		enum fbq_type rt;
-- 
2.20.1

