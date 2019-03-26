Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4D0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3FD2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732841AbfCZXEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:04:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731483AbfCZXEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:04:40 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2QN4R5f054602
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:04:38 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rftk1pgj0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:04:38 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Mar 2019 23:04:38 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Mar 2019 23:04:33 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2QN4WPm22544574
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Mar 2019 23:04:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4161BB206A;
        Tue, 26 Mar 2019 23:04:32 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12E68B2065;
        Tue, 26 Mar 2019 23:04:32 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Mar 2019 23:04:32 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2B9B816C60F9; Tue, 26 Mar 2019 16:04:33 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 4/4] doc: Fix typos and otherwise modernize checklist.txt
Date:   Tue, 26 Mar 2019 16:04:32 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326230408.GA17069@linux.ibm.com>
References: <20190326230408.GA17069@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19032623-0052-0000-0000-000003A1869E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010820; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180130; UDB=6.00617571; IPR=6.00960845;
 MB=3.00026169; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-26 23:04:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032623-0053-0000-0000-00006048D361
Message-Id: <20190326230432.17963-4-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-26_15:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=712 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903260155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes some issues with Documentation/RCU/checklist.txt.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/RCU/checklist.txt | 43 +++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/Documentation/RCU/checklist.txt b/Documentation/RCU/checklist.txt
index fcc59fea5cd4..e98ff261a438 100644
--- a/Documentation/RCU/checklist.txt
+++ b/Documentation/RCU/checklist.txt
@@ -318,7 +318,7 @@ over a rather long period of time, but improvements are always welcome!
 
 11.	Any lock acquired by an RCU callback must be acquired elsewhere
 	with softirq disabled, e.g., via spin_lock_irqsave(),
-	spin_lock_bh(), etc.  Failing to disable irq on a given
+	spin_lock_bh(), etc.  Failing to disable softirq on a given
 	acquisition of that lock will result in deadlock as soon as
 	the RCU softirq handler happens to run your RCU callback while
 	interrupting that acquisition's critical section.
@@ -331,13 +331,16 @@ over a rather long period of time, but improvements are always welcome!
 	must use whatever locking or other synchronization is required
 	to safely access and/or modify that data structure.
 
-	RCU callbacks are -usually- executed on the same CPU that executed
-	the corresponding call_rcu() or call_srcu().  but are by -no-
-	means guaranteed to be.  For example, if a given CPU goes offline
-	while having an RCU callback pending, then that RCU callback
-	will execute on some surviving CPU.  (If this was not the case,
-	a self-spawning RCU callback would prevent the victim CPU from
-	ever going offline.)
+	Do not assume that RCU callbacks will be executed on the same
+	CPU that executed the corresponding call_rcu() or call_srcu().
+	For example, if a given CPU goes offline while having an RCU
+	callback pending, then that RCU callback will execute on some
+	surviving CPU.	(If this was not the case, a self-spawning RCU
+	callback would prevent the victim CPU from ever going offline.)
+	Furthermore, CPUs designated by rcu_nocbs= might well -always-
+	have their RCU callbacks executed on some other CPUs, in fact,
+	for some  real-time workloads, this is the whole point of using
+	the rcu_nocbs= kernel boot parameter.
 
 13.	Unlike other forms of RCU, it -is- permissible to block in an
 	SRCU read-side critical section (demarked by srcu_read_lock()
@@ -379,8 +382,9 @@ over a rather long period of time, but improvements are always welcome!
 	never sends IPIs to other CPUs, so it is easier on
 	real-time workloads than is synchronize_rcu_expedited().
 
-	Note that rcu_dereference() and rcu_assign_pointer() relate to
-	SRCU just as they do to other forms of RCU.
+	Note that rcu_assign_pointer() relates to SRCU just as it does to
+	other forms of RCU, but instead of rcu_dereference() you should
+	use srcu_dereference() in order to avoid lockdep splats.
 
 14.	The whole point of call_rcu(), synchronize_rcu(), and friends
 	is to wait until all pre-existing readers have finished before
@@ -400,6 +404,9 @@ over a rather long period of time, but improvements are always welcome!
 	read-side critical sections.  It is the responsibility of the
 	RCU update-side primitives to deal with this.
 
+	For SRCU readers, you can use smp_mb__after_srcu_read_unlock()
+	immediately after an srcu_read_unlock() to get a full barrier.
+
 16.	Use CONFIG_PROVE_LOCKING, CONFIG_DEBUG_OBJECTS_RCU_HEAD, and the
 	__rcu sparse checks to validate your RCU code.	These can help
 	find problems as follows:
@@ -423,15 +430,15 @@ over a rather long period of time, but improvements are always welcome!
 	These debugging aids can help you find problems that are
 	otherwise extremely difficult to spot.
 
-17.	If you register a callback using call_rcu() or call_srcu(),
-	and pass in a function defined within a loadable module,
-	then it in necessary to wait for all pending callbacks to
-	be invoked after the last invocation and before unloading
-	that module.  Note that it is absolutely -not- sufficient to
-	wait for a grace period!  The current (say) synchronize_rcu()
-	implementation waits only for all previous callbacks registered
-	on the CPU that synchronize_rcu() is running on, but it is -not-
+17.	If you register a callback using call_rcu() or call_srcu(), and
+	pass in a function defined within a loadable module, then it in
+	necessary to wait for all pending callbacks to be invoked after
+	the last invocation and before unloading that module.  Note that
+	it is absolutely -not- sufficient to wait for a grace period!
+	The current (say) synchronize_rcu() implementation is -not-
 	guaranteed to wait for callbacks registered on other CPUs.
+	Or even on the current CPU if that CPU recently went offline
+	and came back online.
 
 	You instead need to use one of the barrier functions:
 
-- 
2.17.1

