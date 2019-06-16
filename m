Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AEAC31E50
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 15:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F8182183F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 15:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfFPPez convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 11:34:55 -0400
Received: from mga04.intel.com ([192.55.52.120]:47524 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbfFPPez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 11:34:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jun 2019 08:34:54 -0700
X-ExtLoop1: 1
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga007.jf.intel.com with ESMTP; 16 Jun 2019 08:34:54 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 16 Jun 2019 08:34:54 -0700
Received: from crsmsx152.amr.corp.intel.com (172.18.7.35) by
 fmsmsx110.amr.corp.intel.com (10.18.116.10) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 16 Jun 2019 08:34:53 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.187]) by
 CRSMSX152.amr.corp.intel.com ([169.254.5.113]) with mapi id 14.03.0439.000;
 Sun, 16 Jun 2019 09:34:51 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v7 18/18] x86/fsgsbase/64: Add documentation for FSGSBASE
Thread-Topic: [PATCH v7 18/18] x86/fsgsbase/64: Add documentation for
 FSGSBASE
Thread-Index: AQHVBb/wZjduerPLCE6RrgdTn3cIcqabVRAAgADdggCAAjFkAIAAMyQAgABBkwCAADJ4AA==
Date:   Sun, 16 Jun 2019 15:34:50 +0000
Message-ID: <62430B9C-95B6-4EB3-94FA-C16A02B9BD7C@intel.com>
References: <1557309753-24073-1-git-send-email-chang.seok.bae@intel.com>
 <1557309753-24073-19-git-send-email-chang.seok.bae@intel.com>
 <alpine.DEB.2.21.1906132246310.1791@nanos.tec.linutronix.de>
 <EEACF240-4772-417A-B516-95D9003D0D11@intel.com>
 <89BE934A-A392-4CED-83E5-CA4FADDAE6DF@intel.com>
 <alpine.DEB.2.21.1906161038160.1760@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1906161433390.1760@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1906161433390.1760@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.190.226]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FC8223A9CBD124409BE4596677C1925B@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 16, 2019, at 05:34, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> On Sun, 16 Jun 2019, Thomas Gleixner wrote:
>> 
>> Please dont. Send me a delta patch against the documentation. I have queued
>> all the other patches already internally. I did not push it out because I
>> wanted to have proper docs.
> 
> Fixed it up already. About to push it out.
> 

Thanks. This is the diff though.

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 22992c8377952..f667087792747 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -118,7 +118,7 @@ static __always_inline bool should_resched(int preempt_offset)
 
 	/* preempt count == 0 ? */
 	tmp &= ~PREEMPT_NEED_RESCHED;
-	if (tmp)
+	if (tmp != preempt_offset)
 		return false;
 	if (current_thread_info()->preempt_lazy_count)
 		return false;
diff --git a/kernel/softirq.c b/kernel/softirq.c
index c15583162a559..25bcf2f2714ba 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -92,6 +92,34 @@ static inline void softirq_clr_runner(unsigned int sirq)
 	sr->runner[sirq] = NULL;
 }
 
+static bool softirq_check_runner_tsk(struct task_struct *tsk,
+				     unsigned int *pending)
+{
+	bool ret = false;
+
+	if (!tsk)
+		return ret;
+
+	/*
+	 * The wakeup code in rtmutex.c wakes up the task
+	 * _before_ it sets pi_blocked_on to NULL under
+	 * tsk->pi_lock. So we need to check for both: state
+	 * and pi_blocked_on.
+	 * The test against UNINTERRUPTIBLE + ->sleeping_lock is in case the
+	 * task does cpu_chill().
+	 */
+	raw_spin_lock(&tsk->pi_lock);
+	if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING ||
+	    (tsk->state == TASK_UNINTERRUPTIBLE && tsk->sleeping_lock)) {
+		/* Clear all bits pending in that task */
+		*pending &= ~(tsk->softirqs_raised);
+		ret = true;
+	}
+	raw_spin_unlock(&tsk->pi_lock);
+
+	return ret;
+}
+
 /*
  * On preempt-rt a softirq running context might be blocked on a
  * lock. There might be no other runnable task on this CPU because the
@@ -104,6 +132,7 @@ static inline void softirq_clr_runner(unsigned int sirq)
  */
 void softirq_check_pending_idle(void)
 {
+	struct task_struct *tsk;
 	static int rate_limit;
 	struct softirq_runner *sr = this_cpu_ptr(&softirq_runners);
 	u32 warnpending;
@@ -113,24 +142,23 @@ void softirq_check_pending_idle(void)
 		return;
 
 	warnpending = local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK;
+	if (!warnpending)
+		return;
 	for (i = 0; i < NR_SOFTIRQS; i++) {
-		struct task_struct *tsk = sr->runner[i];
+		tsk = sr->runner[i];
 
-		/*
-		 * The wakeup code in rtmutex.c wakes up the task
-		 * _before_ it sets pi_blocked_on to NULL under
-		 * tsk->pi_lock. So we need to check for both: state
-		 * and pi_blocked_on.
-		 */
-		if (tsk) {
-			raw_spin_lock(&tsk->pi_lock);
-			if (tsk->pi_blocked_on || tsk->state == TASK_RUNNING) {
-				/* Clear all bits pending in that task */
-				warnpending &= ~(tsk->softirqs_raised);
-				warnpending &= ~(1 << i);
-			}
-			raw_spin_unlock(&tsk->pi_lock);
-		}
+		if (softirq_check_runner_tsk(tsk, &warnpending))
+			warnpending &= ~(1 << i);
+	}
+
+	if (warnpending) {
+		tsk = __this_cpu_read(ksoftirqd);
+		softirq_check_runner_tsk(tsk, &warnpending);
+	}
+
+	if (warnpending) {
+		tsk = __this_cpu_read(ktimer_softirqd);
+		softirq_check_runner_tsk(tsk, &warnpending);
 	}
 
 	if (warnpending) {
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 851b2134e77f4..6f2736ec4b8ef 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1902,15 +1902,18 @@ void cpu_chill(void)
 {
 	ktime_t chill_time;
 	unsigned int freeze_flag = current->flags & PF_NOFREEZE;
+	long saved_state;
 
+	saved_state = current->state;
 	chill_time = ktime_set(0, NSEC_PER_MSEC);
-	set_current_state(TASK_UNINTERRUPTIBLE);
+	__set_current_state_no_track(TASK_UNINTERRUPTIBLE);
 	current->flags |= PF_NOFREEZE;
 	sleeping_lock_inc();
 	schedule_hrtimeout(&chill_time, HRTIMER_MODE_REL_HARD);
 	sleeping_lock_dec();
 	if (!freeze_flag)
 		current->flags &= ~PF_NOFREEZE;
+	__set_current_state_no_track(saved_state);
 }
 EXPORT_SYMBOL(cpu_chill);
 #endif
diff --git a/localversion-rt b/localversion-rt
index 9f7d0bdbffb18..08b3e75841adc 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt13
+-rt14


