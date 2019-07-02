Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A19C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572BA20989
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfGBQtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:49:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726150AbfGBQte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:49:34 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62GivX8060400;
        Tue, 2 Jul 2019 12:49:26 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tgary8u67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jul 2019 12:49:26 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x62GijE1005469;
        Tue, 2 Jul 2019 16:49:25 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01wdc.us.ibm.com with ESMTP id 2tdym6qdpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jul 2019 16:49:25 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x62GnOmL22479290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jul 2019 16:49:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2E32B2064;
        Tue,  2 Jul 2019 16:49:24 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6D6DB2065;
        Tue,  2 Jul 2019 16:49:24 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Jul 2019 16:49:24 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A133416C0FCF; Tue,  2 Jul 2019 09:49:24 -0700 (PDT)
Date:   Tue, 2 Jul 2019 09:49:24 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Signed-off-by for the fix-late-interrupts patch?
Message-ID: <20190702164924.GX26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190701213930.GA25736@linux.ibm.com>
 <20190702083632.GZ3419@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702083632.GZ3419@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907020183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 10:36:32AM +0200, Peter Zijlstra wrote:
> On Mon, Jul 01, 2019 at 02:39:31PM -0700, Paul E. McKenney wrote:
> > Hello, Peter,
> > 
> > The patch below from your earlier email is doing fine in my testing.
> > May I please add your Signed-of-by and designate you as author?
> 
> Sure, glad it worked :-)

And here is the updated version, fixing a few typos along the way.
If I don't hear otherwise from you, I will push it out via -rcu, but
of course feel free to direct it elsewhere if you prefer.

							Thanx, Paul

------------------------------------------------------------------------

commit 559712d50c90fbaec1a6386d720deb323bb6468e
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Wed Jun 5 07:46:43 2019 -0700

    idle: Prevent late-arriving interrupts from disrupting offline
    
    Scheduling-clock interrupts can arrive late in the CPU-offline process,
    after idle entry and the subsequent call to cpuhp_report_idle_dead().
    Once execution passes the call to rcu_report_dead(), RCU is ignoring
    the CPU, which results in lockdep complaints when the interrupt handler
    uses RCU:
    
    ------------------------------------------------------------------------
    
    =============================
    WARNING: suspicious RCU usage
    5.2.0-rc1+ #681 Not tainted
    -----------------------------
    kernel/sched/fair.c:9542 suspicious rcu_dereference_check() usage!
    
    other info that might help us debug this:
    
    RCU used illegally from offline CPU!
    rcu_scheduler_active = 2, debug_locks = 1
    no locks held by swapper/5/0.
    
    stack backtrace:
    CPU: 5 PID: 0 Comm: swapper/5 Not tainted 5.2.0-rc1+ #681
    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS Bochs 01/01/2011
    Call Trace:
     <IRQ>
     dump_stack+0x5e/0x8b
     trigger_load_balance+0xa8/0x390
     ? tick_sched_do_timer+0x60/0x60
     update_process_times+0x3b/0x50
     tick_sched_handle+0x2f/0x40
     tick_sched_timer+0x32/0x70
     __hrtimer_run_queues+0xd3/0x3b0
     hrtimer_interrupt+0x11d/0x270
     ? sched_clock_local+0xc/0x74
     smp_apic_timer_interrupt+0x79/0x200
     apic_timer_interrupt+0xf/0x20
     </IRQ>
    RIP: 0010:delay_tsc+0x22/0x50
    Code: ff 0f 1f 80 00 00 00 00 65 44 8b 05 18 a7 11 48 0f ae e8 0f 31 48 89 d6 48 c1 e6 20 48 09 c6 eb 0e f3 90 65 8b 05 fe a6 11 48 <41> 39 c0 75 18 0f ae e8 0f 31 48 c1 e2 20 48 09 c2 48 89 d0 48 29
    RSP: 0000:ffff8f92c0157ed0 EFLAGS: 00000212 ORIG_RAX: ffffffffffffff13
    RAX: 0000000000000005 RBX: ffff8c861f356400 RCX: ffff8f92c0157e64
    RDX: 000000321214c8cc RSI: 00000032120daa7f RDI: 0000000000260f15
    RBP: 0000000000000005 R08: 0000000000000005 R09: 0000000000000000
    R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
    R13: 0000000000000000 R14: ffff8c861ee18000 R15: ffff8c861ee18000
     cpuhp_report_idle_dead+0x31/0x60
     do_idle+0x1d5/0x200
     ? _raw_spin_unlock_irqrestore+0x2d/0x40
     cpu_startup_entry+0x14/0x20
     start_secondary+0x151/0x170
     secondary_startup_64+0xa4/0xb0
    
    ------------------------------------------------------------------------
    
    This happens rarely, but can be forced by happen more often by
    placing delays in cpuhp_report_idle_dead() following the call to
    rcu_report_dead().  With this in place, the following rcutorture
    scenario reproduces the problem within a few minutes:
    
    tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 5 --kconfig "CONFIG_DEBUG_LOCK_ALLOC=y CONFIG_PROVE_LOCKING=y" --configs "TREE04"
    
    This commit uses the crude but effective expedient of moving the disabling
    of interrupts within the idle loop to precede the cpu_is_offline()
    check.  It also invokes tick_nohz_idle_stop_tick() instead of
    tick_nohz_idle_stop_tick_protected() to shut off the scheduling-clock
    interrupt, and then removes the latter because there are no other callers.
    
    Signed-off-by: Peter Zijlstra <peterz@infradead.org>
    Cc: Frederic Weisbecker <fweisbec@gmail.com>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Cc: Ingo Molnar <mingo@kernel.org>
    Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>

diff --git a/include/linux/tick.h b/include/linux/tick.h
index f92a10b5e112..196a0a7bfc4f 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -134,14 +134,6 @@ extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
 extern u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time);
-
-static inline void tick_nohz_idle_stop_tick_protected(void)
-{
-	local_irq_disable();
-	tick_nohz_idle_stop_tick();
-	local_irq_enable();
-}
-
 #else /* !CONFIG_NO_HZ_COMMON */
 #define tick_nohz_enabled (0)
 static inline int tick_nohz_tick_stopped(void) { return 0; }
@@ -164,8 +156,6 @@ static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
 }
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
-
-static inline void tick_nohz_idle_stop_tick_protected(void) { }
 #endif /* !CONFIG_NO_HZ_COMMON */
 
 #ifdef CONFIG_NO_HZ_FULL
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f5516bae0c1b..42270ca90d94 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -240,13 +240,14 @@ static void do_idle(void)
 		check_pgt_cache();
 		rmb();
 
+		local_irq_disable();
+
 		if (cpu_is_offline(cpu)) {
-			tick_nohz_idle_stop_tick_protected();
+			tick_nohz_idle_stop_tick();
 			cpuhp_report_idle_dead();
 			arch_cpu_idle_dead();
 		}
 
-		local_irq_disable();
 		arch_cpu_idle_enter();
 
 		/*
