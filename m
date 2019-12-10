Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52378C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57AE2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950225;
	bh=JmTNdF3c3zWnOmZHnDHq4YVWu3XUKnv78qUmyBzvnPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AFGIz0RTfdRzH4Qb8WbeJc+9+JBwaoqnBr+1nWXdDBthnb7LbjLARhgkua1BEZ9mO
	 /O2jncqh0qmShZDyPspRRiK7YeaneOOruiRyM5u2nLVbU894gboLv/vamehlAN6AtQ
	 2zsHBcR2NIKV+1KykM2Vv99BQgZv1BeWWSoLQ2YI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfLJD5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:57:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbfLJD4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:56:47 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3BEF20828;
        Tue, 10 Dec 2019 03:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950205;
        bh=JmTNdF3c3zWnOmZHnDHq4YVWu3XUKnv78qUmyBzvnPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1PfJgHh1vbESxF2rfMVSNCZnY8bxAsshQgPatWETaBl9HmQJhpxUi0Fkrm/jDOi7N
         69nNFExQc53knPp++MaIPzbUy2n9Ffcw9PYSYm+tiSqIIjnmKYTb6Q4WKFimCvqcAQ
         nODnqCrpSrK4IbaDrVAQL7BRCc6Dh15AQOuyrV94=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Phong Tran <tranmanphong@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 3/7] doc: Convert whatisRCU.txt to .rst
Date:   Mon,  9 Dec 2019 19:56:37 -0800
Message-Id: <20191210035641.2226-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210035539.GA792@paulmck-ThinkPad-P72>
References: <20191210035539.GA792@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phong Tran <tranmanphong@gmail.com>

This commit updates whatisRCU.txt to the new .rst format.
This change includes:

- Formatting bullet lists
- Adding literal blocks
- Links from table of contents to corresponding sections
- Links to external documents
- Reformat quick quizzes

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
Tested-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
[ tranmanphong: Apply Amol Grover feedback. ]
Reviewed-by: Amol Grover <frextrite@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/index.rst                        |   1 +
 Documentation/RCU/{whatisRCU.txt => whatisRCU.rst} | 284 +++++++++++++--------
 2 files changed, 178 insertions(+), 107 deletions(-)
 rename Documentation/RCU/{whatisRCU.txt => whatisRCU.rst} (84%)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 627128c..b9b1148 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -8,6 +8,7 @@ RCU concepts
    :maxdepth: 3
 
    arrayRCU
+   whatisRCU
    rcu
    listRCU
    NMI-RCU
diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.rst
similarity index 84%
rename from Documentation/RCU/whatisRCU.txt
rename to Documentation/RCU/whatisRCU.rst
index 58ba05c..2f6f6eb 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.rst
@@ -1,15 +1,18 @@
+.. _whatisrcu_doc:
+
 What is RCU?  --  "Read, Copy, Update"
+======================================
 
 Please note that the "What is RCU?" LWN series is an excellent place
 to start learning about RCU:
 
-1.	What is RCU, Fundamentally?  http://lwn.net/Articles/262464/
-2.	What is RCU? Part 2: Usage   http://lwn.net/Articles/263130/
-3.	RCU part 3: the RCU API      http://lwn.net/Articles/264090/
-4.	The RCU API, 2010 Edition    http://lwn.net/Articles/418853/
-	2010 Big API Table           http://lwn.net/Articles/419086/
-5.	The RCU API, 2014 Edition    http://lwn.net/Articles/609904/
-	2014 Big API Table           http://lwn.net/Articles/609973/
+| 1.	What is RCU, Fundamentally?  http://lwn.net/Articles/262464/
+| 2.	What is RCU? Part 2: Usage   http://lwn.net/Articles/263130/
+| 3.	RCU part 3: the RCU API      http://lwn.net/Articles/264090/
+| 4.	The RCU API, 2010 Edition    http://lwn.net/Articles/418853/
+| 	2010 Big API Table           http://lwn.net/Articles/419086/
+| 5.	The RCU API, 2014 Edition    http://lwn.net/Articles/609904/
+|	2014 Big API Table           http://lwn.net/Articles/609973/
 
 
 What is RCU?
@@ -24,14 +27,21 @@ the experience has been that different people must take different paths
 to arrive at an understanding of RCU.  This document provides several
 different paths, as follows:
 
-1.	RCU OVERVIEW
-2.	WHAT IS RCU'S CORE API?
-3.	WHAT ARE SOME EXAMPLE USES OF CORE RCU API?
-4.	WHAT IF MY UPDATING THREAD CANNOT BLOCK?
-5.	WHAT ARE SOME SIMPLE IMPLEMENTATIONS OF RCU?
-6.	ANALOGY WITH READER-WRITER LOCKING
-7.	FULL LIST OF RCU APIs
-8.	ANSWERS TO QUICK QUIZZES
+:ref:`1.	RCU OVERVIEW <1_whatisRCU>`
+
+:ref:`2.	WHAT IS RCU'S CORE API? <2_whatisRCU>`
+
+:ref:`3.	WHAT ARE SOME EXAMPLE USES OF CORE RCU API? <3_whatisRCU>`
+
+:ref:`4.	WHAT IF MY UPDATING THREAD CANNOT BLOCK? <4_whatisRCU>`
+
+:ref:`5.	WHAT ARE SOME SIMPLE IMPLEMENTATIONS OF RCU? <5_whatisRCU>`
+
+:ref:`6.	ANALOGY WITH READER-WRITER LOCKING <6_whatisRCU>`
+
+:ref:`7.	FULL LIST OF RCU APIs <7_whatisRCU>`
+
+:ref:`8.	ANSWERS TO QUICK QUIZZES <8_whatisRCU>`
 
 People who prefer starting with a conceptual overview should focus on
 Section 1, though most readers will profit by reading this section at
@@ -49,8 +59,10 @@ everything, feel free to read the whole thing -- but if you are really
 that type of person, you have perused the source code and will therefore
 never need this document anyway.  ;-)
 
+.. _1_whatisRCU:
 
 1.  RCU OVERVIEW
+----------------
 
 The basic idea behind RCU is to split updates into "removal" and
 "reclamation" phases.  The removal phase removes references to data items
@@ -116,8 +128,10 @@ So how the heck can a reclaimer tell when a reader is done, given
 that readers are not doing any sort of synchronization operations???
 Read on to learn about how RCU's API makes this easy.
 
+.. _2_whatisRCU:
 
 2.  WHAT IS RCU'S CORE API?
+---------------------------
 
 The core RCU API is quite small:
 
@@ -136,7 +150,7 @@ later.  See the kernel docbook documentation for more info, or look directly
 at the function header comments.
 
 rcu_read_lock()
-
+^^^^^^^^^^^^^^^
 	void rcu_read_lock(void);
 
 	Used by a reader to inform the reclaimer that the reader is
@@ -150,7 +164,7 @@ rcu_read_lock()
 	longer-term references to data structures.
 
 rcu_read_unlock()
-
+^^^^^^^^^^^^^^^^^
 	void rcu_read_unlock(void);
 
 	Used by a reader to inform the reclaimer that the reader is
@@ -158,15 +172,15 @@ rcu_read_unlock()
 	read-side critical sections may be nested and/or overlapping.
 
 synchronize_rcu()
-
+^^^^^^^^^^^^^^^^^
 	void synchronize_rcu(void);
 
 	Marks the end of updater code and the beginning of reclaimer
 	code.  It does this by blocking until all pre-existing RCU
 	read-side critical sections on all CPUs have completed.
-	Note that synchronize_rcu() will -not- necessarily wait for
+	Note that synchronize_rcu() will **not** necessarily wait for
 	any subsequent RCU read-side critical sections to complete.
-	For example, consider the following sequence of events:
+	For example, consider the following sequence of events::
 
 	         CPU 0                  CPU 1                 CPU 2
 	     ----------------- ------------------------- ---------------
@@ -182,7 +196,7 @@ synchronize_rcu()
 	any that begin after synchronize_rcu() is invoked.
 
 	Of course, synchronize_rcu() does not necessarily return
-	-immediately- after the last pre-existing RCU read-side critical
+	**immediately** after the last pre-existing RCU read-side critical
 	section completes.  For one thing, there might well be scheduling
 	delays.  For another thing, many RCU implementations process
 	requests in batches in order to improve efficiencies, which can
@@ -211,10 +225,10 @@ synchronize_rcu()
 	checklist.txt for some approaches to limiting the update rate.
 
 rcu_assign_pointer()
-
+^^^^^^^^^^^^^^^^^^^^
 	void rcu_assign_pointer(p, typeof(p) v);
 
-	Yes, rcu_assign_pointer() -is- implemented as a macro, though it
+	Yes, rcu_assign_pointer() **is** implemented as a macro, though it
 	would be cool to be able to declare a function in this manner.
 	(Compiler experts will no doubt disagree.)
 
@@ -231,7 +245,7 @@ rcu_assign_pointer()
 	the _rcu list-manipulation primitives such as list_add_rcu().
 
 rcu_dereference()
-
+^^^^^^^^^^^^^^^^^
 	typeof(p) rcu_dereference(p);
 
 	Like rcu_assign_pointer(), rcu_dereference() must be implemented
@@ -248,13 +262,13 @@ rcu_dereference()
 
 	Common coding practice uses rcu_dereference() to copy an
 	RCU-protected pointer to a local variable, then dereferences
-	this local variable, for example as follows:
+	this local variable, for example as follows::
 
 		p = rcu_dereference(head.next);
 		return p->data;
 
 	However, in this case, one could just as easily combine these
-	into one statement:
+	into one statement::
 
 		return rcu_dereference(head.next)->data;
 
@@ -266,8 +280,8 @@ rcu_dereference()
 	unnecessary overhead on Alpha CPUs.
 
 	Note that the value returned by rcu_dereference() is valid
-	only within the enclosing RCU read-side critical section [1].
-	For example, the following is -not- legal:
+	only within the enclosing RCU read-side critical section [1]_.
+	For example, the following is **not** legal::
 
 		rcu_read_lock();
 		p = rcu_dereference(head.next);
@@ -290,9 +304,9 @@ rcu_dereference()
 	at any time, including immediately after the rcu_dereference().
 	And, again like rcu_assign_pointer(), rcu_dereference() is
 	typically used indirectly, via the _rcu list-manipulation
-	primitives, such as list_for_each_entry_rcu() [2].
+	primitives, such as list_for_each_entry_rcu() [2]_.
 
-	[1] The variant rcu_dereference_protected() can be used outside
+.. 	[1] The variant rcu_dereference_protected() can be used outside
 	of an RCU read-side critical section as long as the usage is
 	protected by locks acquired by the update-side code.  This variant
 	avoids the lockdep warning that would happen when using (for
@@ -305,7 +319,7 @@ rcu_dereference()
 	a lockdep splat is emitted.  See Documentation/RCU/Design/Requirements/Requirements.rst
 	and the API's code comments for more details and example usage.
 
-	[2] If the list_for_each_entry_rcu() instance might be used by
+.. 	[2] If the list_for_each_entry_rcu() instance might be used by
 	update-side code as well as by RCU readers, then an additional
 	lockdep expression can be added to its list of arguments.
 	For example, given an additional "lock_is_held(&mylock)" argument,
@@ -315,6 +329,7 @@ rcu_dereference()
 
 The following diagram shows how each API communicates among the
 reader, updater, and reclaimer.
+::
 
 
 	    rcu_assign_pointer()
@@ -375,12 +390,16 @@ c.	RCU applied to scheduler and interrupt/NMI-handler tasks.
 Again, most uses will be of (a).  The (b) and (c) cases are important
 for specialized uses, but are relatively uncommon.
 
+.. _3_whatisRCU:
 
 3.  WHAT ARE SOME EXAMPLE USES OF CORE RCU API?
+-----------------------------------------------
 
 This section shows a simple use of the core RCU API to protect a
 global pointer to a dynamically allocated structure.  More-typical
-uses of RCU may be found in listRCU.txt, arrayRCU.txt, and NMI-RCU.txt.
+uses of RCU may be found in :ref:`listRCU.rst <list_rcu_doc>`,
+:ref:`arrayRCU.rst <array_rcu_doc>`, and :ref:`NMI-RCU.rst <NMI_rcu_doc>`.
+::
 
 	struct foo {
 		int a;
@@ -440,40 +459,43 @@ uses of RCU may be found in listRCU.txt, arrayRCU.txt, and NMI-RCU.txt.
 
 So, to sum up:
 
-o	Use rcu_read_lock() and rcu_read_unlock() to guard RCU
+-	Use rcu_read_lock() and rcu_read_unlock() to guard RCU
 	read-side critical sections.
 
-o	Within an RCU read-side critical section, use rcu_dereference()
+-	Within an RCU read-side critical section, use rcu_dereference()
 	to dereference RCU-protected pointers.
 
-o	Use some solid scheme (such as locks or semaphores) to
+-	Use some solid scheme (such as locks or semaphores) to
 	keep concurrent updates from interfering with each other.
 
-o	Use rcu_assign_pointer() to update an RCU-protected pointer.
+-	Use rcu_assign_pointer() to update an RCU-protected pointer.
 	This primitive protects concurrent readers from the updater,
-	-not- concurrent updates from each other!  You therefore still
+	**not** concurrent updates from each other!  You therefore still
 	need to use locking (or something similar) to keep concurrent
 	rcu_assign_pointer() primitives from interfering with each other.
 
-o	Use synchronize_rcu() -after- removing a data element from an
-	RCU-protected data structure, but -before- reclaiming/freeing
+-	Use synchronize_rcu() **after** removing a data element from an
+	RCU-protected data structure, but **before** reclaiming/freeing
 	the data element, in order to wait for the completion of all
 	RCU read-side critical sections that might be referencing that
 	data item.
 
 See checklist.txt for additional rules to follow when using RCU.
-And again, more-typical uses of RCU may be found in listRCU.txt,
-arrayRCU.txt, and NMI-RCU.txt.
+And again, more-typical uses of RCU may be found in :ref:`listRCU.rst
+<list_rcu_doc>`, :ref:`arrayRCU.rst <array_rcu_doc>`, and :ref:`NMI-RCU.rst
+<NMI_rcu_doc>`.
 
+.. _4_whatisRCU:
 
 4.  WHAT IF MY UPDATING THREAD CANNOT BLOCK?
+--------------------------------------------
 
 In the example above, foo_update_a() blocks until a grace period elapses.
 This is quite simple, but in some cases one cannot afford to wait so
 long -- there might be other high-priority work to be done.
 
 In such cases, one uses call_rcu() rather than synchronize_rcu().
-The call_rcu() API is as follows:
+The call_rcu() API is as follows::
 
 	void call_rcu(struct rcu_head * head,
 		      void (*func)(struct rcu_head *head));
@@ -481,7 +503,7 @@ The call_rcu() API is as follows:
 This function invokes func(head) after a grace period has elapsed.
 This invocation might happen from either softirq or process context,
 so the function is not permitted to block.  The foo struct needs to
-have an rcu_head structure added, perhaps as follows:
+have an rcu_head structure added, perhaps as follows::
 
 	struct foo {
 		int a;
@@ -490,7 +512,7 @@ have an rcu_head structure added, perhaps as follows:
 		struct rcu_head rcu;
 	};
 
-The foo_update_a() function might then be written as follows:
+The foo_update_a() function might then be written as follows::
 
 	/*
 	 * Create a new struct foo that is the same as the one currently
@@ -520,7 +542,7 @@ The foo_update_a() function might then be written as follows:
 		call_rcu(&old_fp->rcu, foo_reclaim);
 	}
 
-The foo_reclaim() function might appear as follows:
+The foo_reclaim() function might appear as follows::
 
 	void foo_reclaim(struct rcu_head *rp)
 	{
@@ -544,7 +566,7 @@ namely foo_reclaim().
 The summary of advice is the same as for the previous section, except
 that we are now using call_rcu() rather than synchronize_rcu():
 
-o	Use call_rcu() -after- removing a data element from an
+-	Use call_rcu() **after** removing a data element from an
 	RCU-protected data structure in order to register a callback
 	function that will be invoked after the completion of all RCU
 	read-side critical sections that might be referencing that
@@ -552,14 +574,16 @@ o	Use call_rcu() -after- removing a data element from an
 
 If the callback for call_rcu() is not doing anything more than calling
 kfree() on the structure, you can use kfree_rcu() instead of call_rcu()
-to avoid having to write your own callback:
+to avoid having to write your own callback::
 
 	kfree_rcu(old_fp, rcu);
 
 Again, see checklist.txt for additional rules governing the use of RCU.
 
+.. _5_whatisRCU:
 
 5.  WHAT ARE SOME SIMPLE IMPLEMENTATIONS OF RCU?
+------------------------------------------------
 
 One of the nice things about RCU is that it has extremely simple "toy"
 implementations that are a good first step towards understanding the
@@ -579,7 +603,7 @@ more details on the current implementation as of early 2004.
 
 
 5A.  "TOY" IMPLEMENTATION #1: LOCKING
-
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 This section presents a "toy" RCU implementation that is based on
 familiar locking primitives.  Its overhead makes it a non-starter for
 real-life use, as does its lack of scalability.  It is also unsuitable
@@ -591,7 +615,7 @@ you allow nested rcu_read_lock() calls, you can deadlock.
 However, it is probably the easiest implementation to relate to, so is
 a good starting point.
 
-It is extremely simple:
+It is extremely simple::
 
 	static DEFINE_RWLOCK(rcu_gp_mutex);
 
@@ -614,7 +638,7 @@ It is extremely simple:
 
 [You can ignore rcu_assign_pointer() and rcu_dereference() without missing
 much.  But here are simplified versions anyway.  And whatever you do,
-don't forget about them when submitting patches making use of RCU!]
+don't forget about them when submitting patches making use of RCU!]::
 
 	#define rcu_assign_pointer(p, v) \
 	({ \
@@ -647,18 +671,23 @@ that the only thing that can block rcu_read_lock() is a synchronize_rcu().
 But synchronize_rcu() does not acquire any locks while holding rcu_gp_mutex,
 so there can be no deadlock cycle.
 
-Quick Quiz #1:	Why is this argument naive?  How could a deadlock
+.. _quiz_1:
+
+Quick Quiz #1:
+		Why is this argument naive?  How could a deadlock
 		occur when using this algorithm in a real-world Linux
 		kernel?  How could this deadlock be avoided?
 
+:ref:`Answers to Quick Quiz <8_whatisRCU>`
 
 5B.  "TOY" EXAMPLE #2: CLASSIC RCU
-
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 This section presents a "toy" RCU implementation that is based on
 "classic RCU".  It is also short on performance (but only for updates) and
 on features such as hotplug CPU and the ability to run in CONFIG_PREEMPT
 kernels.  The definitions of rcu_dereference() and rcu_assign_pointer()
 are the same as those shown in the preceding section, so they are omitted.
+::
 
 	void rcu_read_lock(void) { }
 
@@ -683,14 +712,14 @@ CPU in turn.  The run_on() primitive can be implemented straightforwardly
 in terms of the sched_setaffinity() primitive.  Of course, a somewhat less
 "toy" implementation would restore the affinity upon completion rather
 than just leaving all tasks running on the last CPU, but when I said
-"toy", I meant -toy-!
+"toy", I meant **toy**!
 
 So how the heck is this supposed to work???
 
 Remember that it is illegal to block while in an RCU read-side critical
 section.  Therefore, if a given CPU executes a context switch, we know
 that it must have completed all preceding RCU read-side critical sections.
-Once -all- CPUs have executed a context switch, then -all- preceding
+Once **all** CPUs have executed a context switch, then **all** preceding
 RCU read-side critical sections will have completed.
 
 So, suppose that we remove a data item from its structure and then invoke
@@ -698,19 +727,32 @@ synchronize_rcu().  Once synchronize_rcu() returns, we are guaranteed
 that there are no RCU read-side critical sections holding a reference
 to that data item, so we can safely reclaim it.
 
-Quick Quiz #2:	Give an example where Classic RCU's read-side
-		overhead is -negative-.
+.. _quiz_2:
+
+Quick Quiz #2:
+		Give an example where Classic RCU's read-side
+		overhead is **negative**.
+
+:ref:`Answers to Quick Quiz <8_whatisRCU>`
 
-Quick Quiz #3:  If it is illegal to block in an RCU read-side
+.. _quiz_3:
+
+Quick Quiz #3:
+		If it is illegal to block in an RCU read-side
 		critical section, what the heck do you do in
 		PREEMPT_RT, where normal spinlocks can block???
 
+:ref:`Answers to Quick Quiz <8_whatisRCU>`
+
+.. _6_whatisRCU:
 
 6.  ANALOGY WITH READER-WRITER LOCKING
+--------------------------------------
 
 Although RCU can be used in many different ways, a very common use of
 RCU is analogous to reader-writer locking.  The following unified
 diff shows how closely related RCU and reader-writer locking can be.
+::
 
 	@@ -5,5 +5,5 @@ struct el {
 	 	int data;
@@ -762,7 +804,7 @@ diff shows how closely related RCU and reader-writer locking can be.
 		return 0;
 	 }
 
-Or, for those who prefer a side-by-side listing:
+Or, for those who prefer a side-by-side listing::
 
  1 struct el {                          1 struct el {
  2   struct list_head list;             2   struct list_head list;
@@ -774,40 +816,44 @@ Or, for those who prefer a side-by-side listing:
  8 rwlock_t listmutex;                  8 spinlock_t listmutex;
  9 struct el head;                      9 struct el head;
 
- 1 int search(long key, int *result)    1 int search(long key, int *result)
- 2 {                                    2 {
- 3   struct list_head *lp;              3   struct list_head *lp;
- 4   struct el *p;                      4   struct el *p;
- 5                                      5
- 6   read_lock(&listmutex);             6   rcu_read_lock();
- 7   list_for_each_entry(p, head, lp) { 7   list_for_each_entry_rcu(p, head, lp) {
- 8     if (p->key == key) {             8     if (p->key == key) {
- 9       *result = p->data;             9       *result = p->data;
-10       read_unlock(&listmutex);      10       rcu_read_unlock();
-11       return 1;                     11       return 1;
-12     }                               12     }
-13   }                                 13   }
-14   read_unlock(&listmutex);          14   rcu_read_unlock();
-15   return 0;                         15   return 0;
-16 }                                   16 }
-
- 1 int delete(long key)                 1 int delete(long key)
- 2 {                                    2 {
- 3   struct el *p;                      3   struct el *p;
- 4                                      4
- 5   write_lock(&listmutex);            5   spin_lock(&listmutex);
- 6   list_for_each_entry(p, head, lp) { 6   list_for_each_entry(p, head, lp) {
- 7     if (p->key == key) {             7     if (p->key == key) {
- 8       list_del(&p->list);            8       list_del_rcu(&p->list);
- 9       write_unlock(&listmutex);      9       spin_unlock(&listmutex);
-                                       10       synchronize_rcu();
-10       kfree(p);                     11       kfree(p);
-11       return 1;                     12       return 1;
-12     }                               13     }
-13   }                                 14   }
-14   write_unlock(&listmutex);         15   spin_unlock(&listmutex);
-15   return 0;                         16   return 0;
-16 }                                   17 }
+::
+
+  1 int search(long key, int *result)    1 int search(long key, int *result)
+  2 {                                    2 {
+  3   struct list_head *lp;              3   struct list_head *lp;
+  4   struct el *p;                      4   struct el *p;
+  5                                      5
+  6   read_lock(&listmutex);             6   rcu_read_lock();
+  7   list_for_each_entry(p, head, lp) { 7   list_for_each_entry_rcu(p, head, lp) {
+  8     if (p->key == key) {             8     if (p->key == key) {
+  9       *result = p->data;             9       *result = p->data;
+ 10       read_unlock(&listmutex);      10       rcu_read_unlock();
+ 11       return 1;                     11       return 1;
+ 12     }                               12     }
+ 13   }                                 13   }
+ 14   read_unlock(&listmutex);          14   rcu_read_unlock();
+ 15   return 0;                         15   return 0;
+ 16 }                                   16 }
+
+::
+
+  1 int delete(long key)                 1 int delete(long key)
+  2 {                                    2 {
+  3   struct el *p;                      3   struct el *p;
+  4                                      4
+  5   write_lock(&listmutex);            5   spin_lock(&listmutex);
+  6   list_for_each_entry(p, head, lp) { 6   list_for_each_entry(p, head, lp) {
+  7     if (p->key == key) {             7     if (p->key == key) {
+  8       list_del(&p->list);            8       list_del_rcu(&p->list);
+  9       write_unlock(&listmutex);      9       spin_unlock(&listmutex);
+                                        10       synchronize_rcu();
+ 10       kfree(p);                     11       kfree(p);
+ 11       return 1;                     12       return 1;
+ 12     }                               13     }
+ 13   }                                 14   }
+ 14   write_unlock(&listmutex);         15   spin_unlock(&listmutex);
+ 15   return 0;                         16   return 0;
+ 16 }                                   17 }
 
 Either way, the differences are quite small.  Read-side locking moves
 to rcu_read_lock() and rcu_read_unlock, update-side locking moves from
@@ -825,15 +871,17 @@ delete() can now block.  If this is a problem, there is a callback-based
 mechanism that never blocks, namely call_rcu() or kfree_rcu(), that can
 be used in place of synchronize_rcu().
 
+.. _7_whatisRCU:
 
 7.  FULL LIST OF RCU APIs
+-------------------------
 
 The RCU APIs are documented in docbook-format header comments in the
 Linux-kernel source code, but it helps to have a full list of the
 APIs, since there does not appear to be a way to categorize them
 in docbook.  Here is the list, by category.
 
-RCU list traversal:
+RCU list traversal::
 
 	list_entry_rcu
 	list_first_entry_rcu
@@ -854,7 +902,7 @@ RCU list traversal:
 	hlist_bl_first_rcu
 	hlist_bl_for_each_entry_rcu
 
-RCU pointer/list update:
+RCU pointer/list udate::
 
 	rcu_assign_pointer
 	list_add_rcu
@@ -876,7 +924,9 @@ RCU pointer/list update:
 	hlist_bl_del_rcu
 	hlist_bl_set_first_rcu
 
-RCU:	Critical sections	Grace period		Barrier
+RCU::
+
+	Critical sections	Grace period		Barrier
 
 	rcu_read_lock		synchronize_net		rcu_barrier
 	rcu_read_unlock		synchronize_rcu
@@ -885,7 +935,9 @@ RCU:	Critical sections	Grace period		Barrier
 	rcu_dereference_check	kfree_rcu
 	rcu_dereference_protected
 
-bh:	Critical sections	Grace period		Barrier
+bh::
+
+	Critical sections	Grace period		Barrier
 
 	rcu_read_lock_bh	call_rcu		rcu_barrier
 	rcu_read_unlock_bh	synchronize_rcu
@@ -896,7 +948,9 @@ bh:	Critical sections	Grace period		Barrier
 	rcu_dereference_bh_protected
 	rcu_read_lock_bh_held
 
-sched:	Critical sections	Grace period		Barrier
+sched::
+
+	Critical sections	Grace period		Barrier
 
 	rcu_read_lock_sched	call_rcu		rcu_barrier
 	rcu_read_unlock_sched	synchronize_rcu
@@ -910,7 +964,9 @@ sched:	Critical sections	Grace period		Barrier
 	rcu_read_lock_sched_held
 
 
-SRCU:	Critical sections	Grace period		Barrier
+SRCU::
+
+	Critical sections	Grace period		Barrier
 
 	srcu_read_lock		call_srcu		srcu_barrier
 	srcu_read_unlock	synchronize_srcu
@@ -918,13 +974,14 @@ SRCU:	Critical sections	Grace period		Barrier
 	srcu_dereference_check
 	srcu_read_lock_held
 
-SRCU:	Initialization/cleanup
+SRCU: Initialization/cleanup::
+
 	DEFINE_SRCU
 	DEFINE_STATIC_SRCU
 	init_srcu_struct
 	cleanup_srcu_struct
 
-All:  lockdep-checked RCU-protected pointer access
+All: lockdep-checked RCU-protected pointer access::
 
 	rcu_access_pointer
 	rcu_dereference_raw
@@ -974,15 +1031,19 @@ g.	Otherwise, use RCU.
 Of course, this all assumes that you have determined that RCU is in fact
 the right tool for your job.
 
+.. _8_whatisRCU:
 
 8.  ANSWERS TO QUICK QUIZZES
+----------------------------
 
-Quick Quiz #1:	Why is this argument naive?  How could a deadlock
+Quick Quiz #1:
+		Why is this argument naive?  How could a deadlock
 		occur when using this algorithm in a real-world Linux
 		kernel?  [Referring to the lock-based "toy" RCU
 		algorithm.]
 
-Answer:		Consider the following sequence of events:
+Answer:
+		Consider the following sequence of events:
 
 		1.	CPU 0 acquires some unrelated lock, call it
 			"problematic_lock", disabling irq via
@@ -1021,10 +1082,14 @@ Answer:		Consider the following sequence of events:
 		approach where tasks in RCU read-side critical sections
 		cannot be blocked by tasks executing synchronize_rcu().
 
-Quick Quiz #2:	Give an example where Classic RCU's read-side
-		overhead is -negative-.
+:ref:`Back to Quick Quiz #1 <quiz_1>`
+
+Quick Quiz #2:
+		Give an example where Classic RCU's read-side
+		overhead is **negative**.
 
-Answer:		Imagine a single-CPU system with a non-CONFIG_PREEMPT
+Answer:
+		Imagine a single-CPU system with a non-CONFIG_PREEMPT
 		kernel where a routing table is used by process-context
 		code, but can be updated by irq-context code (for example,
 		by an "ICMP REDIRECT" packet).	The usual way of handling
@@ -1046,11 +1111,15 @@ Answer:		Imagine a single-CPU system with a non-CONFIG_PREEMPT
 		even the theoretical possibility of negative overhead for
 		a synchronization primitive is a bit unexpected.  ;-)
 
-Quick Quiz #3:  If it is illegal to block in an RCU read-side
+:ref:`Back to Quick Quiz #2 <quiz_2>`
+
+Quick Quiz #3:
+		If it is illegal to block in an RCU read-side
 		critical section, what the heck do you do in
 		PREEMPT_RT, where normal spinlocks can block???
 
-Answer:		Just as PREEMPT_RT permits preemption of spinlock
+Answer:
+		Just as PREEMPT_RT permits preemption of spinlock
 		critical sections, it permits preemption of RCU
 		read-side critical sections.  It also permits
 		spinlocks blocking while in RCU read-side critical
@@ -1069,6 +1138,7 @@ Answer:		Just as PREEMPT_RT permits preemption of spinlock
 		Besides, how does the computer know what pizza parlor
 		the human being went to???
 
+:ref:`Back to Quick Quiz #3 <quiz_3>`
 
 ACKNOWLEDGEMENTS
 
-- 
2.9.5

