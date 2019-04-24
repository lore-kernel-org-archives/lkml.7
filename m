Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAE0C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C389218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfDXAIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:08:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:18306 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbfDXAIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:08:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 17:08:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,387,1549958400"; 
   d="scan'208";a="133824452"
Received: from schen9-desk.jf.intel.com (HELO [10.54.74.162]) ([10.54.74.162])
  by orsmga007.jf.intel.com with ESMTP; 23 Apr 2019 17:08:08 -0700
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, subhra.mazumdar@oracle.com,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1556025155.git.vpillai@digitalocean.com>
 <2364f2b65bf50826d881c84d7634b6565dfee527.1556025155.git.vpillai@digitalocean.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tim.c.chen@linux.intel.com; prefer-encrypt=mutual; keydata=
 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
 l50q2K/r651xphs7CGEdKi1nU0YJVbQxJQ==
Subject: Re: [RFC PATCH v2 11/17] sched: Basic tracking of matching tasks
Message-ID: <54772e18-2f70-34cc-29ef-b9291f4846e2@linux.intel.com>
Date:   Tue, 23 Apr 2019 17:08:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <2364f2b65bf50826d881c84d7634b6565dfee527.1556025155.git.vpillai@digitalocean.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/19 9:18 AM, Vineeth Remanan Pillai wrote:

> +/* real prio, less is less */
> +static inline bool __prio_less(struct task_struct *a, struct task_struct *b, bool core_cmp)
> +{
> +	u64 vruntime;
> +
> +	int pa = __task_prio(a), pb = __task_prio(b);
> +
> +	if (-pa < -pb)
> +		return true;
> +
> +	if (-pb < -pa)
> +		return false;
> +
> +	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
> +		return !dl_time_before(a->dl.deadline, b->dl.deadline);
> +
> +	vruntime = b->se.vruntime;
> +	if (core_cmp) {
> +		vruntime -= task_cfs_rq(b)->min_vruntime;
> +		vruntime += task_cfs_rq(a)->min_vruntime;
> +	}
> +	if (pa == MAX_RT_PRIO + MAX_NICE) /* fair */
> +		return !((s64)(a->se.vruntime - vruntime) <= 0);
> +
> +	return false;
> +}
> +
> +static inline bool cpu_prio_less(struct task_struct *a, struct task_struct *b)
> +{
> +	return __prio_less(a, b, false);
> +}
> +
> +static inline bool core_prio_less(struct task_struct *a, struct task_struct *b)
> +{
> +	return __prio_less(a, b, true);
> +}
> +
> +static inline bool __sched_core_less(struct task_struct *a, struct task_struct *b)
> +{
> +	if (a->core_cookie < b->core_cookie)
> +		return true;
> +
> +	if (a->core_cookie > b->core_cookie)
> +		return false;
> +
> +	/* flip prio, so high prio is leftmost */
> +	if (cpu_prio_less(b, a))
> +		return true;
> +
> +	return false;
> +}
> +

A minor nitpick.  I find keeping the vruntime base readjustment in
core_prio_less probably is more straight forward rather than pass a
core_cmp bool around.

Tim


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 455e7ecc2f48..5917fb85669b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -100,15 +87,13 @@ static inline struct cfs_rq *task_cfs_rq(struct task_struct *p)
  */
 
 /* real prio, less is less */
-static inline bool __prio_less(struct task_struct *a, struct task_struct *b, bool core_cmp)
+static inline bool __prio_less(struct task_struct *a, struct task_struct *b, u64 vruntime)
 {
-	u64 vruntime;
-
 	int pa = __task_prio(a), pb = __task_prio(b);
 
 	trace_printk("(%s/%d;%d,%Lu,%Lu) ?< (%s/%d;%d,%Lu,%Lu)\n",
-		     a->comm, a->pid, pa, a->se.vruntime, a->dl.deadline,
-		     b->comm, b->pid, pa, b->se.vruntime, b->dl.deadline);
+			a->comm, a->pid, pa, a->se.vruntime, a->dl.deadline,
+			b->comm, b->pid, pa, b->se.vruntime, b->dl.deadline);
 
 	if (-pa < -pb)
 		return true;
@@ -119,11 +104,6 @@ static inline bool __prio_less(struct task_struct *a, struct task_struct *b, boo
 	if (pa == -1) /* dl_prio() doesn't work because of stop_class above */
 		return !dl_time_before(a->dl.deadline, b->dl.deadline);
 
-	vruntime = b->se.vruntime;
-	if (core_cmp) {
-		vruntime -= task_cfs_rq(b)->min_vruntime;
-		vruntime += task_cfs_rq(a)->min_vruntime;
-	}
 	if (pa == MAX_RT_PRIO + MAX_NICE) /* fair */
 		return !((s64)(a->se.vruntime - vruntime) <= 0);
 
@@ -132,12 +112,17 @@ static inline bool __prio_less(struct task_struct *a, struct task_struct *b, boo
 
 static inline bool cpu_prio_less(struct task_struct *a, struct task_struct *b)
 {
-	return __prio_less(a, b, false);
+	return __prio_less(a, b, b->se.vruntime);
 }
 
 static inline bool core_prio_less(struct task_struct *a, struct task_struct *b)
 {
-	return __prio_less(a, b, true);
+	u64 vruntime = b->se.vruntime;
+
+	vruntime -= task_cfs_rq(b)->min_vruntime;
+	vruntime += task_cfs_rq(a)->min_vruntime;
+
+	return __prio_less(a, b, vruntime);
 }
 
 static inline bool __sched_core_less(struct task_struct *a, struct task_struct *b)
