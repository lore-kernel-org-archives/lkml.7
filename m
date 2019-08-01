Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC84BC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B51206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 22:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390103AbfHAWut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 18:50:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732058AbfHAWuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 18:50:37 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71MlEix117260
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 18:50:36 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u45u87517-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 18:50:36 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 1 Aug 2019 23:50:35 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Aug 2019 23:50:29 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x71MoSY048169314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 22:50:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B839B207E;
        Thu,  1 Aug 2019 22:50:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B182B2070;
        Thu,  1 Aug 2019 22:50:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  1 Aug 2019 22:50:28 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B337216C9A50; Thu,  1 Aug 2019 15:50:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 02/11] rcu/nocb: Update comments to prepare for forward-progress work
Date:   Thu,  1 Aug 2019 15:50:19 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190801225009.GA17155@linux.ibm.com>
References: <20190801225009.GA17155@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19080122-0064-0000-0000-00000405791F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011535; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01240738; UDB=6.00654297; IPR=6.01022162;
 MB=3.00028000; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-01 22:50:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080122-0065-0000-0000-00003E81F07E
Message-Id: <20190801225028.18225-2-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit simply rewords comments to prepare for leader nocb kthreads
doing only grace-period work and callback shuffling.  This will mean
the addition of replacement kthreads to invoke callbacks.  The "leader"
and "follower" thus become less meaningful, so the commit changes no-CB
comments with these strings to "GP" and "CB", respectively.  (Give or
take the usual grammatical transformations.)

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.h        |  8 +++---
 kernel/rcu/tree_plugin.h | 57 ++++++++++++++++++++--------------------
 2 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e4e59b627c5a..32b3348d3a4d 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -206,17 +206,17 @@ struct rcu_data {
 	int nocb_defer_wakeup;		/* Defer wakeup of nocb_kthread. */
 	struct timer_list nocb_timer;	/* Enforce finite deferral. */
 
-	/* The following fields are used by the leader, hence own cacheline. */
+	/* The following fields are used by GP kthread, hence own cacheline. */
 	struct rcu_head *nocb_gp_head ____cacheline_internodealigned_in_smp;
 					/* CBs waiting for GP. */
 	struct rcu_head **nocb_gp_tail;
-	bool nocb_gp_sleep;		/* Is the nocb leader thread asleep? */
+	bool nocb_gp_sleep;		/* Is the nocb GP thread asleep? */
 	struct rcu_data *nocb_next_cb_rdp;
 					/* Next rcu_data in wakeup chain. */
 
-	/* The following fields are used by the follower, hence new cachline. */
+	/* The following fields are used by CB kthread, hence new cachline. */
 	struct rcu_data *nocb_gp_rdp ____cacheline_internodealigned_in_smp;
-					/* Leader CPU takes GP-end wakeups. */
+					/* GP rdp takes GP-end wakeups. */
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
 
 	/* 6) RCU priority boosting. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 5ce1edd1c87f..5a72700c3a32 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1447,10 +1447,10 @@ static void rcu_cleanup_after_idle(void)
  * specified by rcu_nocb_mask.  For the CPUs in the set, there are kthreads
  * created that pull the callbacks from the corresponding CPU, wait for
  * a grace period to elapse, and invoke the callbacks.  These kthreads
- * are organized into leaders, which manage incoming callbacks, wait for
- * grace periods, and awaken followers, and the followers, which only
- * invoke callbacks.  Each leader is its own follower.  The no-CBs CPUs
- * do a wake_up() on their kthread when they insert a callback into any
+ * are organized into GP kthreads, which manage incoming callbacks, wait for
+ * grace periods, and awaken CB kthreads, and the CB kthreads, which only
+ * invoke callbacks.  Each GP kthread invokes its own CBs.  The no-CBs CPUs
+ * do a wake_up() on their GP kthread when they insert a callback into any
  * empty list, unless the rcu_nocb_poll boot parameter has been specified,
  * in which case each kthread actively polls its CPU.  (Which isn't so great
  * for energy efficiency, but which does reduce RCU's overhead on that CPU.)
@@ -1521,7 +1521,7 @@ bool rcu_is_nocb_cpu(int cpu)
 }
 
 /*
- * Kick the leader kthread for this NOCB group.  Caller holds ->nocb_lock
+ * Kick the GP kthread for this NOCB group.  Caller holds ->nocb_lock
  * and this function releases it.
  */
 static void __wake_nocb_leader(struct rcu_data *rdp, bool force,
@@ -1548,7 +1548,7 @@ static void __wake_nocb_leader(struct rcu_data *rdp, bool force,
 }
 
 /*
- * Kick the leader kthread for this NOCB group, but caller has not
+ * Kick the GP kthread for this NOCB group, but caller has not
  * acquired locks.
  */
 static void wake_nocb_leader(struct rcu_data *rdp, bool force)
@@ -1560,8 +1560,8 @@ static void wake_nocb_leader(struct rcu_data *rdp, bool force)
 }
 
 /*
- * Arrange to wake the leader kthread for this NOCB group at some
- * future time when it is safe to do so.
+ * Arrange to wake the GP kthread for this NOCB group at some future
+ * time when it is safe to do so.
  */
 static void wake_nocb_leader_defer(struct rcu_data *rdp, int waketype,
 				   const char *reason)
@@ -1783,7 +1783,7 @@ static void rcu_nocb_wait_gp(struct rcu_data *rdp)
 }
 
 /*
- * Leaders come here to wait for additional callbacks to show up.
+ * No-CBs GP kthreads come here to wait for additional callbacks to show up.
  * This function does not return until callbacks appear.
  */
 static void nocb_leader_wait(struct rcu_data *my_rdp)
@@ -1812,8 +1812,8 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
 	}
 
 	/*
-	 * Each pass through the following loop checks a follower for CBs.
-	 * We are our own first follower.  Any CBs found are moved to
+	 * Each pass through the following loop checks for CBs.
+	 * We are our own first CB kthread.  Any CBs found are moved to
 	 * nocb_gp_head, where they await a grace period.
 	 */
 	gotcbs = false;
@@ -1821,7 +1821,7 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
 	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
 		rdp->nocb_gp_head = READ_ONCE(rdp->nocb_head);
 		if (!rdp->nocb_gp_head)
-			continue;  /* No CBs here, try next follower. */
+			continue;  /* No CBs here, try next. */
 
 		/* Move callbacks to wait-for-GP list, which is empty. */
 		WRITE_ONCE(rdp->nocb_head, NULL);
@@ -1844,7 +1844,7 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
 	/* Wait for one grace period. */
 	rcu_nocb_wait_gp(my_rdp);
 
-	/* Each pass through the following loop wakes a follower, if needed. */
+	/* Each pass through this loop wakes a CB kthread, if needed. */
 	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
 		if (!rcu_nocb_poll &&
 		    READ_ONCE(rdp->nocb_head) &&
@@ -1854,27 +1854,27 @@ static void nocb_leader_wait(struct rcu_data *my_rdp)
 			raw_spin_unlock_irqrestore(&my_rdp->nocb_lock, flags);
 		}
 		if (!rdp->nocb_gp_head)
-			continue; /* No CBs, so no need to wake follower. */
+			continue; /* No CBs, so no need to wake kthread. */
 
-		/* Append callbacks to follower's "done" list. */
+		/* Append callbacks to CB kthread's "done" list. */
 		raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
 		tail = rdp->nocb_cb_tail;
 		rdp->nocb_cb_tail = rdp->nocb_gp_tail;
 		*tail = rdp->nocb_gp_head;
 		raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
 		if (rdp != my_rdp && tail == &rdp->nocb_cb_head) {
-			/* List was empty, so wake up the follower.  */
+			/* List was empty, so wake up the kthread.  */
 			swake_up_one(&rdp->nocb_wq);
 		}
 	}
 
-	/* If we (the leader) don't have CBs, go wait some more. */
+	/* If we (the GP kthreads) don't have CBs, go wait some more. */
 	if (!my_rdp->nocb_cb_head)
 		goto wait_again;
 }
 
 /*
- * Followers come here to wait for additional callbacks to show up.
+ * No-CBs CB kthreads come here to wait for additional callbacks to show up.
  * This function does not return until callbacks appear.
  */
 static void nocb_follower_wait(struct rcu_data *rdp)
@@ -1894,9 +1894,10 @@ static void nocb_follower_wait(struct rcu_data *rdp)
 
 /*
  * Per-rcu_data kthread, but only for no-CBs CPUs.  Each kthread invokes
- * callbacks queued by the corresponding no-CBs CPU, however, there is
- * an optional leader-follower relationship so that the grace-period
- * kthreads don't have to do quite so many wakeups.
+ * callbacks queued by the corresponding no-CBs CPU, however, there is an
+ * optional GP-CB relationship so that the grace-period kthreads don't
+ * have to do quite so many wakeups (as in they only need to wake the
+ * no-CBs GP kthreads, not the CB kthreads).
  */
 static int rcu_nocb_kthread(void *arg)
 {
@@ -2056,7 +2057,7 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 /*
  * If the specified CPU is a no-CBs CPU that does not already have its
  * rcuo kthread, spawn it.  If the CPUs are brought online out of order,
- * this can require re-organizing the leader-follower relationships.
+ * this can require re-organizing the GP-CB relationships.
  */
 static void rcu_spawn_one_nocb_kthread(int cpu)
 {
@@ -2073,7 +2074,7 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
 	if (!rcu_is_nocb_cpu(cpu) || rdp_spawn->nocb_cb_kthread)
 		return;
 
-	/* If we didn't spawn the leader first, reorganize! */
+	/* If we didn't spawn the GP kthread first, reorganize! */
 	rdp_old_leader = rdp_spawn->nocb_gp_rdp;
 	if (rdp_old_leader != rdp_spawn && !rdp_old_leader->nocb_cb_kthread) {
 		rdp_last = NULL;
@@ -2125,18 +2126,18 @@ static void __init rcu_spawn_nocb_kthreads(void)
 		rcu_spawn_cpu_nocb_kthread(cpu);
 }
 
-/* How many follower CPU IDs per leader?  Default of -1 for sqrt(nr_cpu_ids). */
+/* How many CB CPU IDs per GP kthread?  Default of -1 for sqrt(nr_cpu_ids). */
 static int rcu_nocb_leader_stride = -1;
 module_param(rcu_nocb_leader_stride, int, 0444);
 
 /*
- * Initialize leader-follower relationships for all no-CBs CPU.
+ * Initialize GP-CB relationships for all no-CBs CPU.
  */
 static void __init rcu_organize_nocb_kthreads(void)
 {
 	int cpu;
 	int ls = rcu_nocb_leader_stride;
-	int nl = 0;  /* Next leader. */
+	int nl = 0;  /* Next GP kthread. */
 	struct rcu_data *rdp;
 	struct rcu_data *rdp_leader = NULL;  /* Suppress misguided gcc warn. */
 	struct rcu_data *rdp_prev = NULL;
@@ -2156,12 +2157,12 @@ static void __init rcu_organize_nocb_kthreads(void)
 	for_each_cpu(cpu, rcu_nocb_mask) {
 		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (rdp->cpu >= nl) {
-			/* New leader, set up for followers & next leader. */
+			/* New GP kthread, set up for CBs & next GP. */
 			nl = DIV_ROUND_UP(rdp->cpu + 1, ls) * ls;
 			rdp->nocb_gp_rdp = rdp;
 			rdp_leader = rdp;
 		} else {
-			/* Another follower, link to previous leader. */
+			/* Another CB kthread, link to previous GP kthread. */
 			rdp->nocb_gp_rdp = rdp_leader;
 			rdp_prev->nocb_next_cb_rdp = rdp;
 		}
-- 
2.17.1

