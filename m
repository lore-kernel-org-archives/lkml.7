Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03123C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3579213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732921AbfCZXEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:04:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732804AbfCZXEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:04:42 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QN4NJd062331
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:04:40 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rft2qyu8y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:04:40 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:04:39 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:04:33 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QN4WI111665618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:04:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D81AB2067;
        Tue, 26 Mar 2019 23:04:32 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 01D86B2070;
        Tue, 26 Mar 2019 23:04:31 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:04:31 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1973C16C60F3; Tue, 26 Mar 2019 16:04:33 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 1/4] doc: Remove obsolete RCU update functions from RCU documentation
Date:   Tue, 26 Mar 2019 16:04:29 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326230408.GA17069@linux.ibm.com>
References: <20190326230408.GA17069@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0068-0000-0000-000003AB740E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180130; UDB=6.00617570; IPR=6.00960845;
 MB=3.00026169; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:04:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0069-0000-0000-000047F2194E
Message-Id: <20190326230432.17963-1-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=43 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that synchronize_rcu_bh, synchronize_rcu_bh_expedited, call_rcu_bh,
rcu_barrier_bh, synchronize_sched, synchronize_sched_expedited,
call_rcu_sched, rcu_barrier_sched, get_state_synchronize_sched,
and cond_synchronize_sched are obsolete, let's remove them from the
documentation aside from a small historical section.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 .../Data-Structures/Data-Structures.html      |  3 +-
 .../Expedited-Grace-Periods.html              |  4 +-
 .../Tree-RCU-Memory-Ordering.html             |  5 +-
 Documentation/RCU/NMI-RCU.txt                 | 13 ++--
 Documentation/RCU/UP.txt                      |  6 +-
 Documentation/RCU/checklist.txt               | 76 +++++++++----------
 Documentation/RCU/rcu.txt                     |  8 +-
 Documentation/RCU/rcubarrier.txt              | 27 ++++---
 8 files changed, 66 insertions(+), 76 deletions(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.html b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
index 18f179807563..c30c1957c7e6 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.html
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
@@ -155,8 +155,7 @@ keeping lock contention under control at all tree levels regardless
 of the level of loading on the system.
 
 </p><p>RCU updaters wait for normal grace periods by registering
-RCU callbacks, either directly via <tt>call_rcu()</tt> and
-friends (namely <tt>call_rcu_bh()</tt> and <tt>call_rcu_sched()</tt>),
+RCU callbacks, either directly via <tt>call_rcu()</tt>
 or indirectly via <tt>synchronize_rcu()</tt> and friends.
 RCU callbacks are represented by <tt>rcu_head</tt> structures,
 which are queued on <tt>rcu_data</tt> structures while they are
diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
index 19e7a5fb6b73..57300db4b5ff 100644
--- a/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
+++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.html
@@ -56,6 +56,7 @@ sections.
 RCU-preempt Expedited Grace Periods</a></h2>
 
 <p>
+<tt>CONFIG_PREEMPT=y</tt> kernels implement RCU-preempt.
 The overall flow of the handling of a given CPU by an RCU-preempt
 expedited grace period is shown in the following diagram:
 
@@ -139,6 +140,7 @@ or offline, among other things.
 RCU-sched Expedited Grace Periods</a></h2>
 
 <p>
+<tt>CONFIG_PREEMPT=n</tt> kernels implement RCU-sched.
 The overall flow of the handling of a given CPU by an RCU-sched
 expedited grace period is shown in the following diagram:
 
@@ -146,7 +148,7 @@ expedited grace period is shown in the following diagram:
 
 <p>
 As with RCU-preempt, RCU-sched's
-<tt>synchronize_sched_expedited()</tt> ignores offline and
+<tt>synchronize_rcu_expedited()</tt> ignores offline and
 idle CPUs, again because they are in remotely detectable
 quiescent states.
 However, because the
diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
index 8d21af02b1f0..c64f8d26609f 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
@@ -34,12 +34,11 @@ Similarly, any code that happens before the beginning of a given RCU grace
 period is guaranteed to see the effects of all accesses following the end
 of that grace period that are within RCU read-side critical sections.
 
-<p>This guarantee is particularly pervasive for <tt>synchronize_sched()</tt>,
-for which RCU-sched read-side critical sections include any region
+<p>Note well that RCU-sched read-side critical sections include any region
 of code for which preemption is disabled.
 Given that each individual machine instruction can be thought of as
 an extremely small region of preemption-disabled code, one can think of
-<tt>synchronize_sched()</tt> as <tt>smp_mb()</tt> on steroids.
+<tt>synchronize_rcu()</tt> as <tt>smp_mb()</tt> on steroids.
 
 <p>RCU updaters use this guarantee by splitting their updates into
 two phases, one of which is executed before the grace period and
diff --git a/Documentation/RCU/NMI-RCU.txt b/Documentation/RCU/NMI-RCU.txt
index 687777f83b23..881353fd5bff 100644
--- a/Documentation/RCU/NMI-RCU.txt
+++ b/Documentation/RCU/NMI-RCU.txt
@@ -81,18 +81,19 @@ currently executing on some other CPU.  We therefore cannot free
 up any data structures used by the old NMI handler until execution
 of it completes on all other CPUs.
 
-One way to accomplish this is via synchronize_sched(), perhaps as
+One way to accomplish this is via synchronize_rcu(), perhaps as
 follows:
 
 	unset_nmi_callback();
-	synchronize_sched();
+	synchronize_rcu();
 	kfree(my_nmi_data);
 
-This works because synchronize_sched() blocks until all CPUs complete
-any preemption-disabled segments of code that they were executing.
-Since NMI handlers disable preemption, synchronize_sched() is guaranteed
+This works because (as of v4.20) synchronize_rcu() blocks until all
+CPUs complete any preemption-disabled segments of code that they were
+executing.
+Since NMI handlers disable preemption, synchronize_rcu() is guaranteed
 not to return until all ongoing NMI handlers exit.  It is therefore safe
-to free up the handler's data as soon as synchronize_sched() returns.
+to free up the handler's data as soon as synchronize_rcu() returns.
 
 Important note: for this to work, the architecture in question must
 invoke nmi_enter() and nmi_exit() on NMI entry and exit, respectively.
diff --git a/Documentation/RCU/UP.txt b/Documentation/RCU/UP.txt
index 90ec5341ee98..53bde717017b 100644
--- a/Documentation/RCU/UP.txt
+++ b/Documentation/RCU/UP.txt
@@ -86,10 +86,8 @@ even on a UP system.  So do not do it!  Even on a UP system, the RCU
 infrastructure -must- respect grace periods, and -must- invoke callbacks
 from a known environment in which no locks are held.
 
-It -is- safe for synchronize_sched() and synchronize_rcu_bh() to return
-immediately on an UP system.  It is also safe for synchronize_rcu()
-to return immediately on UP systems, except when running preemptable
-RCU.
+Note that it -is- safe for synchronize_rcu() to return immediately on
+UP systems, including !PREEMPT SMP builds running on UP systems.
 
 Quick Quiz #3: Why can't synchronize_rcu() return immediately on
 	UP systems running preemptable RCU?
diff --git a/Documentation/RCU/checklist.txt b/Documentation/RCU/checklist.txt
index 6f469864d9f5..fcc59fea5cd4 100644
--- a/Documentation/RCU/checklist.txt
+++ b/Documentation/RCU/checklist.txt
@@ -182,16 +182,13 @@ over a rather long period of time, but improvements are always welcome!
 		when publicizing a pointer to a structure that can
 		be traversed by an RCU read-side critical section.
 
-5.	If call_rcu(), or a related primitive such as call_rcu_bh(),
-	call_rcu_sched(), or call_srcu() is used, the callback function
-	will be called from softirq context.  In particular, it cannot
-	block.
+5.	If call_rcu() or call_srcu() is used, the callback function will
+	be called from softirq context.  In particular, it cannot block.
 
-6.	Since synchronize_rcu() can block, it cannot be called from
-	any sort of irq context.  The same rule applies for
-	synchronize_rcu_bh(), synchronize_sched(), synchronize_srcu(),
-	synchronize_rcu_expedited(), synchronize_rcu_bh_expedited(),
-	synchronize_sched_expedite(), and synchronize_srcu_expedited().
+6.	Since synchronize_rcu() can block, it cannot be called
+	from any sort of irq context.  The same rule applies
+	for synchronize_srcu(), synchronize_rcu_expedited(), and
+	synchronize_srcu_expedited().
 
 	The expedited forms of these primitives have the same semantics
 	as the non-expedited forms, but expediting is both expensive and
@@ -212,20 +209,20 @@ over a rather long period of time, but improvements are always welcome!
 	of the system, especially to real-time workloads running on
 	the rest of the system.
 
-7.	If the updater uses call_rcu() or synchronize_rcu(), then the
-	corresponding readers must use rcu_read_lock() and
-	rcu_read_unlock().  If the updater uses call_rcu_bh() or
-	synchronize_rcu_bh(), then the corresponding readers must
-	use rcu_read_lock_bh() and rcu_read_unlock_bh().  If the
-	updater uses call_rcu_sched() or synchronize_sched(), then
-	the corresponding readers must disable preemption, possibly
-	by calling rcu_read_lock_sched() and rcu_read_unlock_sched().
-	If the updater uses synchronize_srcu() or call_srcu(), then
-	the corresponding readers must use srcu_read_lock() and
+7.	As of v4.20, a given kernel implements only one RCU flavor,
+	which is RCU-sched for PREEMPT=n and RCU-preempt for PREEMPT=y.
+	If the updater uses call_rcu() or synchronize_rcu(),
+	then the corresponding readers my use rcu_read_lock() and
+	rcu_read_unlock(), rcu_read_lock_bh() and rcu_read_unlock_bh(),
+	or any pair of primitives that disables and re-enables preemption,
+	for example, rcu_read_lock_sched() and rcu_read_unlock_sched().
+	If the updater uses synchronize_srcu() or call_srcu(),
+	then the corresponding readers must use srcu_read_lock() and
 	srcu_read_unlock(), and with the same srcu_struct.  The rules for
 	the expedited primitives are the same as for their non-expedited
 	counterparts.  Mixing things up will result in confusion and
-	broken kernels.
+	broken kernels, and has even resulted in an exploitable security
+	issue.
 
 	One exception to this rule: rcu_read_lock() and rcu_read_unlock()
 	may be substituted for rcu_read_lock_bh() and rcu_read_unlock_bh()
@@ -288,8 +285,7 @@ over a rather long period of time, but improvements are always welcome!
 	d.	Periodically invoke synchronize_rcu(), permitting a limited
 		number of updates per grace period.
 
-	The same cautions apply to call_rcu_bh(), call_rcu_sched(),
-	call_srcu(), and kfree_rcu().
+	The same cautions apply to call_srcu() and kfree_rcu().
 
 	Note that although these primitives do take action to avoid memory
 	exhaustion when any given CPU has too many callbacks, a determined
@@ -336,12 +332,12 @@ over a rather long period of time, but improvements are always welcome!
 	to safely access and/or modify that data structure.
 
 	RCU callbacks are -usually- executed on the same CPU that executed
-	the corresponding call_rcu(), call_rcu_bh(), or call_rcu_sched(),
-	but are by -no- means guaranteed to be.  For example, if a given
-	CPU goes offline while having an RCU callback pending, then that
-	RCU callback will execute on some surviving CPU.  (If this was
-	not the case, a self-spawning RCU callback would prevent the
-	victim CPU from ever going offline.)
+	the corresponding call_rcu() or call_srcu().  but are by -no-
+	means guaranteed to be.  For example, if a given CPU goes offline
+	while having an RCU callback pending, then that RCU callback
+	will execute on some surviving CPU.  (If this was not the case,
+	a self-spawning RCU callback would prevent the victim CPU from
+	ever going offline.)
 
 13.	Unlike other forms of RCU, it -is- permissible to block in an
 	SRCU read-side critical section (demarked by srcu_read_lock()
@@ -381,8 +377,7 @@ over a rather long period of time, but improvements are always welcome!
 
 	SRCU's expedited primitive (synchronize_srcu_expedited())
 	never sends IPIs to other CPUs, so it is easier on
-	real-time workloads than is synchronize_rcu_expedited(),
-	synchronize_rcu_bh_expedited() or synchronize_sched_expedited().
+	real-time workloads than is synchronize_rcu_expedited().
 
 	Note that rcu_dereference() and rcu_assign_pointer() relate to
 	SRCU just as they do to other forms of RCU.
@@ -428,22 +423,19 @@ over a rather long period of time, but improvements are always welcome!
 	These debugging aids can help you find problems that are
 	otherwise extremely difficult to spot.
 
-17.	If you register a callback using call_rcu(), call_rcu_bh(),
-	call_rcu_sched(), or call_srcu(), and pass in a function defined
-	within a loadable module, then it in necessary to wait for
-	all pending callbacks to be invoked after the last invocation
-	and before unloading that module.  Note that it is absolutely
-	-not- sufficient to wait for a grace period!  The current (say)
-	synchronize_rcu() implementation waits only for all previous
-	callbacks registered on the CPU that synchronize_rcu() is running
-	on, but it is -not- guaranteed to wait for callbacks registered
-	on other CPUs.
+17.	If you register a callback using call_rcu() or call_srcu(),
+	and pass in a function defined within a loadable module,
+	then it in necessary to wait for all pending callbacks to
+	be invoked after the last invocation and before unloading
+	that module.  Note that it is absolutely -not- sufficient to
+	wait for a grace period!  The current (say) synchronize_rcu()
+	implementation waits only for all previous callbacks registered
+	on the CPU that synchronize_rcu() is running on, but it is -not-
+	guaranteed to wait for callbacks registered on other CPUs.
 
 	You instead need to use one of the barrier functions:
 
 	o	call_rcu() -> rcu_barrier()
-	o	call_rcu_bh() -> rcu_barrier()
-	o	call_rcu_sched() -> rcu_barrier()
 	o	call_srcu() -> srcu_barrier()
 
 	However, these barrier functions are absolutely -not- guaranteed
diff --git a/Documentation/RCU/rcu.txt b/Documentation/RCU/rcu.txt
index 721b3e426515..c818cf65c5a9 100644
--- a/Documentation/RCU/rcu.txt
+++ b/Documentation/RCU/rcu.txt
@@ -52,10 +52,10 @@ o	If I am running on a uniprocessor kernel, which can only do one
 o	How can I see where RCU is currently used in the Linux kernel?
 
 	Search for "rcu_read_lock", "rcu_read_unlock", "call_rcu",
-	"rcu_read_lock_bh", "rcu_read_unlock_bh", "call_rcu_bh",
-	"srcu_read_lock", "srcu_read_unlock", "synchronize_rcu",
-	"synchronize_net", "synchronize_srcu", and the other RCU
-	primitives.  Or grab one of the cscope databases from:
+	"rcu_read_lock_bh", "rcu_read_unlock_bh", "srcu_read_lock",
+	"srcu_read_unlock", "synchronize_rcu", "synchronize_net",
+	"synchronize_srcu", and the other RCU primitives.  Or grab one
+	of the cscope databases from:
 
 	http://www.rdrop.com/users/paulmck/RCU/linuxusage/rculocktab.html
 
diff --git a/Documentation/RCU/rcubarrier.txt b/Documentation/RCU/rcubarrier.txt
index 5d7759071a3e..a2782df69732 100644
--- a/Documentation/RCU/rcubarrier.txt
+++ b/Documentation/RCU/rcubarrier.txt
@@ -83,16 +83,15 @@ Pseudo-code using rcu_barrier() is as follows:
    2. Execute rcu_barrier().
    3. Allow the module to be unloaded.
 
-There are also rcu_barrier_bh(), rcu_barrier_sched(), and srcu_barrier()
-functions for the other flavors of RCU, and you of course must match
-the flavor of rcu_barrier() with that of call_rcu().  If your module
-uses multiple flavors of call_rcu(), then it must also use multiple
+There is also an srcu_barrier() function for SRCU, and you of course
+must match the flavor of rcu_barrier() with that of call_rcu().  If your
+module uses multiple flavors of call_rcu(), then it must also use multiple
 flavors of rcu_barrier() when unloading that module.  For example, if
-it uses call_rcu_bh(), call_srcu() on srcu_struct_1, and call_srcu() on
+it uses call_rcu(), call_srcu() on srcu_struct_1, and call_srcu() on
 srcu_struct_2(), then the following three lines of code will be required
 when unloading:
 
- 1 rcu_barrier_bh();
+ 1 rcu_barrier();
  2 srcu_barrier(&srcu_struct_1);
  3 srcu_barrier(&srcu_struct_2);
 
@@ -185,12 +184,12 @@ module invokes call_rcu() from timers, you will need to first cancel all
 the timers, and only then invoke rcu_barrier() to wait for any remaining
 RCU callbacks to complete.
 
-Of course, if you module uses call_rcu_bh(), you will need to invoke
-rcu_barrier_bh() before unloading.  Similarly, if your module uses
-call_rcu_sched(), you will need to invoke rcu_barrier_sched() before
-unloading.  If your module uses call_rcu(), call_rcu_bh(), -and-
-call_rcu_sched(), then you will need to invoke each of rcu_barrier(),
-rcu_barrier_bh(), and rcu_barrier_sched().
+Of course, if you module uses call_rcu(), you will need to invoke
+rcu_barrier() before unloading.  Similarly, if your module uses
+call_srcu(), you will need to invoke srcu_barrier() before unloading,
+and on the same srcu_struct structure.  If your module uses call_rcu()
+-and- call_srcu(), then you will need to invoke rcu_barrier() -and-
+srcu_barrier().
 
 
 Implementing rcu_barrier()
@@ -223,8 +222,8 @@ shown below. Note that the final "1" in on_each_cpu()'s argument list
 ensures that all the calls to rcu_barrier_func() will have completed
 before on_each_cpu() returns. Line 9 then waits for the completion.
 
-This code was rewritten in 2008 to support rcu_barrier_bh() and
-rcu_barrier_sched() in addition to the original rcu_barrier().
+This code was rewritten in 2008 and several times thereafter, but this
+still gives the general idea.
 
 The rcu_barrier_func() runs on each CPU, where it invokes call_rcu()
 to post an RCU callback, as follows:
-- 
2.17.1

