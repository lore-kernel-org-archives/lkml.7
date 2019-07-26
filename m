Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20002C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFAED217D9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387457AbfGZV35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:29:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:7124 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727398AbfGZV35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:29:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 14:29:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,312,1559545200"; 
   d="scan'208";a="198525760"
Received: from schen9-desk.jf.intel.com (HELO [10.54.74.162]) ([10.54.74.162])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2019 14:29:56 -0700
To:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Cc:     Aubrey Li <aubrey.intel@gmail.com>,
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
References: <20190531210816.GA24027@sinkpad> <20190606152637.GA5703@sinkpad>
 <20190612163345.GB26997@sinkpad>
 <635c01b0-d8f3-561b-5396-10c75ed03712@oracle.com>
 <20190613032246.GA17752@sinkpad>
 <CAERHkrsMFjjBpPZS7jDhzbob4PSmiPj83OfqEeiKgaDAU3ajOA@mail.gmail.com>
 <20190619183302.GA6775@sinkpad> <20190718100714.GA469@aaronlu>
 <CAERHkrtvLKxrpvfw04urAuougsYOWnNw4-H1vUDFx27Dvy0=Ww@mail.gmail.com>
 <20190725143003.GA992@aaronlu> <20190726152101.GA27884@sinkpad>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual; keydata=
 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
 l50q2K/r651xphs7CGEdKi1nU0YJVbQxJQ==
Subject: Re: [RFC PATCH v3 00/16] Core scheduling v3
Message-ID: <f96350c1-25a9-0564-ff46-6658e96d726c@linux.intel.com>
Date:   Fri, 26 Jul 2019 14:29:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190726152101.GA27884@sinkpad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/19 8:21 AM, Julien Desfossez wrote:
> On 25-Jul-2019 10:30:03 PM, Aaron Lu wrote:
>>
>> I tried a different approach based on vruntime with 3 patches following.
> [...]
> 
> We have experimented with this new patchset and indeed the fairness is
> now much better. Interactive tasks with v3 were complete starving when
> there were cpu-intensive tasks running, now they can run consistently.
> With my initial test of TPC-C running in large VMs with a lot of
> background noise VMs, the results are pretty similar to v3, I will run
> more thorough tests and report the results back here.

Aaron's patch inspired me to experiment with another approach to tackle
fairness.  The root problem with v3 was we didn't account for the forced
idle time when we compare the priority of tasks between two threads.

So what I did here is to account the forced idle time in the top cfs_rq's
min_vruntime when we update the runqueue clock.  When we are comparing
between two cfs runqueues, the task in cpu getting forced idle will now
be credited with the forced idle time. The effect should be similar to
Aaron's patches. Logic is a bit simpler and we don't need to use
one of the sibling's cfs_rq min_vruntime as a time base.

In really limited testing, it seems to have balanced fairness between two
tagged cgroups.

Tim

-------patch 1----------
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Wed, 24 Jul 2019 13:58:18 -0700
Subject: [PATCH 1/2] sched: move sched fair prio comparison to fair.c

Move the priority comparison of two tasks in fair class to fair.c.
There is no functional change.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/core.c  | 21 ++-------------------
 kernel/sched/fair.c  | 21 +++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 3 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8ea87be56a1e..f78b8fdfd47c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -105,25 +105,8 @@ static inline bool prio_less(struct task_struct *a, struct task_struct *b)
 	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
 		return !dl_time_before(a->dl.deadline, b->dl.deadline);
 
-	if (pa == MAX_RT_PRIO + MAX_NICE)  { /* fair */
-		u64 a_vruntime = a->se.vruntime;
-		u64 b_vruntime = b->se.vruntime;
-
-		/*
-		 * Normalize the vruntime if tasks are in different cpus.
-		 */
-		if (task_cpu(a) != task_cpu(b)) {
-			b_vruntime -= task_cfs_rq(b)->min_vruntime;
-			b_vruntime += task_cfs_rq(a)->min_vruntime;
-
-			trace_printk("(%d:%Lu,%Lu,%Lu) <> (%d:%Lu,%Lu,%Lu)\n",
-				     a->pid, a_vruntime, a->se.vruntime, task_cfs_rq(a)->min_vruntime,
-				     b->pid, b_vruntime, b->se.vruntime, task_cfs_rq(b)->min_vruntime);
-
-		}
-
-		return !((s64)(a_vruntime - b_vruntime) <= 0);
-	}
+	if (pa == MAX_RT_PRIO + MAX_NICE) /* fair */
+		return prio_less_fair(a, b);
 
 	return false;
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02bff10237d4..e289b6e1545b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -602,6 +602,27 @@ static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
 	return delta;
 }
 
+bool prio_less_fair(struct task_struct *a, struct task_struct *b)
+{
+	u64 a_vruntime = a->se.vruntime;
+	u64 b_vruntime = b->se.vruntime;
+
+	/*
+	 * Normalize the vruntime if tasks are in different cpus.
+	 */
+	if (task_cpu(a) != task_cpu(b)) {
+		b_vruntime -= task_cfs_rq(b)->min_vruntime;
+		b_vruntime += task_cfs_rq(a)->min_vruntime;
+
+		trace_printk("(%d:%Lu,%Lu,%Lu) <> (%d:%Lu,%Lu,%Lu)\n",
+			     a->pid, a_vruntime, a->se.vruntime, task_cfs_rq(a)->min_vruntime,
+			     b->pid, b_vruntime, b->se.vruntime, task_cfs_rq(b)->min_vruntime);
+
+	}
+
+	return !((s64)(a_vruntime - b_vruntime) <= 0);
+}
+
 /*
  * The idea is to set a period in which each task runs once.
  *
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e91c188a452c..bdabe7ce1152 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1015,6 +1015,7 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 }
 
 extern void queue_core_balance(struct rq *rq);
+extern bool prio_less_fair(struct task_struct *a, struct task_struct *b);
 
 #else /* !CONFIG_SCHED_CORE */
 
-- 
2.20.1


--------------patch 2------------------
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Thu, 25 Jul 2019 13:09:21 -0700
Subject: [PATCH 2/2] sched: Account the forced idle time

We did not account for the forced idle time when comparing two tasks
from different SMT thread in the same core.

Account it in root cfs_rq min_vruntime when we update the rq clock.  This will
allow for fair comparison of which task has higher priority from
two different SMT.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/core.c |  6 ++++++
 kernel/sched/fair.c | 22 ++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f78b8fdfd47c..d8fa74810126 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -393,6 +393,12 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 
 	rq->clock_task += delta;
 
+#ifdef CONFIG_SCHED_CORE
+	/* Account the forced idle time by sibling */
+	if (rq->core_forceidle)
+		rq->cfs.min_vruntime += delta;
+#endif
+
 #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
 	if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
 		update_irq_load_avg(rq, irq_delta + steal);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e289b6e1545b..1b2fd1271c51 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -604,20 +604,34 @@ static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
 
 bool prio_less_fair(struct task_struct *a, struct task_struct *b)
 {
-	u64 a_vruntime = a->se.vruntime;
-	u64 b_vruntime = b->se.vruntime;
+	u64 a_vruntime;
+	u64 b_vruntime;
 
 	/*
 	 * Normalize the vruntime if tasks are in different cpus.
 	 */
 	if (task_cpu(a) != task_cpu(b)) {
-		b_vruntime -= task_cfs_rq(b)->min_vruntime;
-		b_vruntime += task_cfs_rq(a)->min_vruntime;
+		struct sched_entity *sea = &a->se;
+		struct sched_entity *seb = &b->se;
+
+		while (sea->parent)
+			sea = sea->parent;
+		while (seb->parent)
+			seb = seb->parent;
+
+		a_vruntime = sea->vruntime;
+		b_vruntime = seb->vruntime;
+
+		b_vruntime -= task_rq(b)->cfs.min_vruntime;
+		b_vruntime += task_rq(a)->cfs.min_vruntime;
 
 		trace_printk("(%d:%Lu,%Lu,%Lu) <> (%d:%Lu,%Lu,%Lu)\n",
 			     a->pid, a_vruntime, a->se.vruntime, task_cfs_rq(a)->min_vruntime,
 			     b->pid, b_vruntime, b->se.vruntime, task_cfs_rq(b)->min_vruntime);
 
+	} else {
+		a_vruntime = a->se.vruntime;
+		b_vruntime = b->se.vruntime;
 	}
 
 	return !((s64)(a_vruntime - b_vruntime) <= 0);
-- 
2.20.1

