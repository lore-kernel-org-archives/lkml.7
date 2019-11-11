Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E43C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A9F20659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfKKTKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:10:48 -0500
Received: from mga01.intel.com ([192.55.52.88]:23147 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfKKTKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:10:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 11:10:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,293,1569308400"; 
   d="scan'208";a="405323803"
Received: from schen9-desk.jf.intel.com (HELO [10.54.74.162]) ([10.54.74.162])
  by fmsmga006.fm.intel.com with ESMTP; 11 Nov 2019 11:10:44 -0800
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual; keydata=
 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
 l50q2K/r651xphs7CGEdKi1nU0YJVbQxJQ==
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com>
Date:   Mon, 11 Nov 2019 11:10:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/19 11:33 AM, Vineeth Remanan Pillai wrote:
> Fourth iteration of the Core-Scheduling feature.
> 
> This version was aiming mostly at addressing the vruntime comparison
> issues with v3. The main issue seen in v3 was the starvation of
> interactive tasks when competing with cpu intensive tasks. This issue
> is mitigated to a large extent.
> 
> We have tested and verified that incompatible processes are not
> selected during schedule. In terms of performance, the impact
> depends on the workload:
> - on CPU intensive applications that use all the logical CPUs with
>   SMT enabled, enabling core scheduling performs better than nosmt.
> - on mixed workloads with considerable io compared to cpu usage,
>   nosmt seems to perform better than core scheduling.
> 
> v4 is rebased on top of 5.3.5(dc073f193b70):
> https://github.com/digitalocean/linux-coresched/tree/coresched/v4-v5.3.5
> 

The v4 core scheduler will crash when you toggle the core scheduling
tag of the cgroup while there are active tasks in the cgroup running.

The reason is because we don't properly move tasks in and out of the
core scheduler queue according to the new core scheduling tag status.
A task's core scheduler status will then get misaligned with its core
cookie status.

The patch below fixes that.

Thanks.

Tim

------->8----------------

From 2f3f035a9b74013627069da62d6553548700eeac Mon Sep 17 00:00:00 2001
From: Tim Chen <tim.c.chen@linux.intel.com>
Date: Thu, 7 Nov 2019 15:45:24 -0500
Subject: [PATCH] sched: Update tasks in core queue when its cgroup tag is
 changed

A task will need to be moved into the core scheduler queue when the cgroup
it belongs to is tagged to run with core scheduling.  Similarly the task
will need to be moved out of the core scheduler queue when the cgroup
is untagged.

Also after we forked a task, its core scheduler queue's presence will
need to be updated according to its new cgroup's status.

Implement these missing core scheduler queue update mechanisms.
Otherwise, the core scheduler will OOPs the kernel when we toggle the
cgroup's core scheduling tag due to inconsistent core scheduler queue
status.

Use stop machine mechanism to update all tasks in a cgroup to prevent a
new task from sneaking into the cgroup, and missed out from the update
while we iterates through all the tasks in the cgroup.  A more complicated
scheme could probably avoid the stop machine.  Such scheme will also
need to resovle inconsistency between a task's cgroup core scheduling
tag and residency in core scheduler queue.

We are opting for the simple stop machine mechanism for now that avoids
such complications.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/core.c | 119 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 106 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4778b5940c30..08e7fdd5972d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -138,6 +138,37 @@ static inline bool __sched_core_less(struct task_struct *a, struct task_struct *
 	return false;
 }
 
+static bool sched_core_empty(struct rq *rq)
+{
+	return RB_EMPTY_ROOT(&rq->core_tree);
+}
+
+static bool sched_core_enqueued(struct task_struct *task)
+{
+	return !RB_EMPTY_NODE(&task->core_node);
+}
+
+static struct task_struct *sched_core_first(struct rq *rq)
+{
+	struct task_struct *task;
+
+	task = container_of(rb_first(&rq->core_tree), struct task_struct, core_node);
+	return task;
+}
+
+static void sched_core_flush(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+	struct task_struct *task;
+
+	while (!sched_core_empty(rq)) {
+		task = sched_core_first(rq);
+		rb_erase(&task->core_node, &rq->core_tree);
+		RB_CLEAR_NODE(&task->core_node);
+	}
+	rq->core->core_task_seq++;
+}
+
 static void sched_core_enqueue(struct rq *rq, struct task_struct *p)
 {
 	struct rb_node *parent, **node;
@@ -169,10 +200,11 @@ static void sched_core_dequeue(struct rq *rq, struct task_struct *p)
 {
 	rq->core->core_task_seq++;
 
-	if (!p->core_cookie)
+	if (!sched_core_enqueued(p))
 		return;
 
 	rb_erase(&p->core_node, &rq->core_tree);
+	RB_CLEAR_NODE(&p->core_node);
 }
 
 /*
@@ -236,6 +268,18 @@ static int __sched_core_stopper(void *data)
 	bool enabled = !!(unsigned long)data;
 	int cpu;
 
+	if (!enabled) {
+		for_each_online_cpu(cpu) {
+		/*
+		 * All active and migrating tasks will have already been removed
+		 * from core queue when we clear the cgroup tags.
+		 * However, dying tasks could still be left in core queue.
+		 * Flush them here.
+		 */
+			sched_core_flush(cpu);
+		}
+	}
+
 	for_each_online_cpu(cpu)
 		cpu_rq(cpu)->core_enabled = enabled;
 
@@ -247,7 +291,11 @@ static int sched_core_count;
 
 static void __sched_core_enable(void)
 {
-	// XXX verify there are no cookie tasks (yet)
+	int cpu;
+
+	/* verify there are no cookie tasks (yet) */
+	for_each_online_cpu(cpu)
+		BUG_ON(!sched_core_empty(cpu_rq(cpu)));
 
 	static_branch_enable(&__sched_core_enabled);
 	stop_machine(__sched_core_stopper, (void *)true, NULL);
@@ -257,8 +305,6 @@ static void __sched_core_enable(void)
 
 static void __sched_core_disable(void)
 {
-	// XXX verify there are no cookie tasks (left)
-
 	stop_machine(__sched_core_stopper, (void *)false, NULL);
 	static_branch_disable(&__sched_core_enabled);
 
@@ -285,6 +331,7 @@ void sched_core_put(void)
 
 static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
 static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
+static bool sched_core_enqueued(struct task_struct *task) { return false; }
 
 #endif /* CONFIG_SCHED_CORE */
 
@@ -3016,6 +3063,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 #ifdef CONFIG_SMP
 	plist_node_init(&p->pushable_tasks, MAX_PRIO);
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
+#endif
+#ifdef CONFIG_SCHED_CORE
+	RB_CLEAR_NODE(&p->core_node);
 #endif
 	return 0;
 }
@@ -6560,6 +6610,9 @@ void init_idle(struct task_struct *idle, int cpu)
 #ifdef CONFIG_SMP
 	sprintf(idle->comm, "%s/%d", INIT_TASK_COMM, cpu);
 #endif
+#ifdef CONFIG_SCHED_CORE
+	RB_CLEAR_NODE(&idle->core_node);
+#endif
 }
 
 #ifdef CONFIG_SMP
@@ -7671,7 +7724,12 @@ static void cpu_cgroup_fork(struct task_struct *task)
 	rq = task_rq_lock(task, &rf);
 
 	update_rq_clock(rq);
+	if (sched_core_enqueued(task))
+		sched_core_dequeue(rq, task);
 	sched_change_group(task, TASK_SET_GROUP);
+	if (sched_core_enabled(rq) && task_on_rq_queued(task) &&
+	    task->core_cookie)
+		sched_core_enqueue(rq, task);
 
 	task_rq_unlock(rq, task, &rf);
 }
@@ -8033,12 +8091,51 @@ static u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css, struct cftype
 	return !!tg->tagged;
 }
 
-static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype *cft, u64 val)
+struct write_core_tag {
+	struct cgroup_subsys_state *css;
+	int val;
+};
+
+static int __sched_write_tag(void *data)
 {
-	struct task_group *tg = css_tg(css);
+	struct write_core_tag *tag = (struct write_core_tag *) data;
+	struct cgroup_subsys_state *css = tag->css;
+	int val = tag->val;
+	struct task_group *tg = css_tg(tag->css);
 	struct css_task_iter it;
 	struct task_struct *p;
 
+	tg->tagged = !!val;
+
+	css_task_iter_start(css, 0, &it);
+	/*
+	 * Note: css_task_iter_next will skip dying tasks.
+	 * There could still be dying tasks left in the core queue
+	 * when we set cgroup tag to 0 when the loop is done below.
+	 */
+	while ((p = css_task_iter_next(&it))) {
+		p->core_cookie = !!val ? (unsigned long)tg : 0UL;
+
+		if (sched_core_enqueued(p)) {
+			sched_core_dequeue(task_rq(p), p);
+			if (!p->core_cookie)
+				continue;
+		}
+
+		if (p->core_cookie && task_on_rq_queued(p))
+			sched_core_enqueue(task_rq(p), p);
+
+	}
+	css_task_iter_end(&it);
+
+	return 0;
+}
+
+static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype *cft, u64 val)
+{
+	struct task_group *tg = css_tg(css);
+	struct write_core_tag wtag;
+
 	if (val > 1)
 		return -ERANGE;
 
@@ -8048,16 +8145,12 @@ static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype
 	if (tg->tagged == !!val)
 		return 0;
 
-	tg->tagged = !!val;
-
 	if (!!val)
 		sched_core_get();
 
-	css_task_iter_start(css, 0, &it);
-	while ((p = css_task_iter_next(&it)))
-		p->core_cookie = !!val ? (unsigned long)tg : 0UL;
-	css_task_iter_end(&it);
-
+	wtag.css = css;
+	wtag.val = val;
+	stop_machine(__sched_write_tag, (void *) &wtag, NULL);
 	if (!val)
 		sched_core_put();
 
-- 
2.20.1

