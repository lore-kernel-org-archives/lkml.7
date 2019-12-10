Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0E3C2D0BE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A7120836
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950217;
	bh=vZAN4fIv0/Uuj7+5sbHUTw1y0xJdP8OCPoXA25TproQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Lir2EKwrxo/ka57jVw/A0VplaJYy/73S/DXAxlHllnMKo+Wp/YgfXy3z5p7j4iKuo
	 sJsAWKdTaLwkt4G9glWgn1ow2VpbXZbtUi4x2v8Oo8K+kPDN5ogHH2ZDsYx/IhhA6x
	 U4VUVIGcYcpF6w3K5TIB1bi0YSyncq2b2k/lyPlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfLJD44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:56:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:39418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbfLJD4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:56:48 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EC3E207FF;
        Tue, 10 Dec 2019 03:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950206;
        bh=vZAN4fIv0/Uuj7+5sbHUTw1y0xJdP8OCPoXA25TproQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bk4MlElz+klJJOYHX9LdrzI4xUsYjvXDYVebJ5U5ww8XI6M6vUP/0tUM+QthwfwPT
         MSfwW1G9O1XJYaNyX+XO61BQ37cb+rjJqWmGEH3mLukdlpNNxINFEg0thDhELiIENL
         wW/xefRpMwC/zF9UTNLP7ywojRqJO6df6Mrnv4Ek=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Amol Grover <frextrite@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 5/7] doc: Convert to rcubarrier.txt to ReST
Date:   Mon,  9 Dec 2019 19:56:39 -0800
Message-Id: <20191210035641.2226-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210035539.GA792@paulmck-ThinkPad-P72>
References: <20191210035539.GA792@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amol Grover <frextrite@gmail.com>

Convert rcubarrier.txt to rcubarrier.rst and add it to index.rst.

Format file according to reST
- Add headings and sub-headings
- Add code segments
- Add cross-references to quizes and answers

Signed-off-by: Amol Grover <frextrite@gmail.com>
Tested-by: Phong Tran <tranmanphong@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/index.rst                        |   1 +
 .../RCU/{rcubarrier.txt => rcubarrier.rst}         | 222 ++++++++++++---------
 2 files changed, 126 insertions(+), 97 deletions(-)
 rename Documentation/RCU/{rcubarrier.txt => rcubarrier.rst} (72%)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index c81d0e4..81a0a1e 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -8,6 +8,7 @@ RCU concepts
    :maxdepth: 3
 
    arrayRCU
+   rcubarrier
    rcu_dereference
    whatisRCU
    rcu
diff --git a/Documentation/RCU/rcubarrier.txt b/Documentation/RCU/rcubarrier.rst
similarity index 72%
rename from Documentation/RCU/rcubarrier.txt
rename to Documentation/RCU/rcubarrier.rst
index a2782df..f64f4413 100644
--- a/Documentation/RCU/rcubarrier.txt
+++ b/Documentation/RCU/rcubarrier.rst
@@ -1,4 +1,7 @@
+.. _rcu_barrier:
+
 RCU and Unloadable Modules
+==========================
 
 [Originally published in LWN Jan. 14, 2007: http://lwn.net/Articles/217484/]
 
@@ -21,7 +24,7 @@ given that readers might well leave absolutely no trace of their
 presence? There is a synchronize_rcu() primitive that blocks until all
 pre-existing readers have completed. An updater wishing to delete an
 element p from a linked list might do the following, while holding an
-appropriate lock, of course:
+appropriate lock, of course::
 
 	list_del_rcu(p);
 	synchronize_rcu();
@@ -32,13 +35,13 @@ primitive must be used instead. This primitive takes a pointer to an
 rcu_head struct placed within the RCU-protected data structure and
 another pointer to a function that may be invoked later to free that
 structure. Code to delete an element p from the linked list from IRQ
-context might then be as follows:
+context might then be as follows::
 
 	list_del_rcu(p);
 	call_rcu(&p->rcu, p_callback);
 
 Since call_rcu() never blocks, this code can safely be used from within
-IRQ context. The function p_callback() might be defined as follows:
+IRQ context. The function p_callback() might be defined as follows::
 
 	static void p_callback(struct rcu_head *rp)
 	{
@@ -49,6 +52,7 @@ IRQ context. The function p_callback() might be defined as follows:
 
 
 Unloading Modules That Use call_rcu()
+-------------------------------------
 
 But what if p_callback is defined in an unloadable module?
 
@@ -69,10 +73,11 @@ in realtime kernels in order to avoid excessive scheduling latencies.
 
 
 rcu_barrier()
+-------------
 
 We instead need the rcu_barrier() primitive.  Rather than waiting for
 a grace period to elapse, rcu_barrier() waits for all outstanding RCU
-callbacks to complete.  Please note that rcu_barrier() does -not- imply
+callbacks to complete.  Please note that rcu_barrier() does **not** imply
 synchronize_rcu(), in particular, if there are no RCU callbacks queued
 anywhere, rcu_barrier() is within its rights to return immediately,
 without waiting for a grace period to elapse.
@@ -88,79 +93,79 @@ must match the flavor of rcu_barrier() with that of call_rcu().  If your
 module uses multiple flavors of call_rcu(), then it must also use multiple
 flavors of rcu_barrier() when unloading that module.  For example, if
 it uses call_rcu(), call_srcu() on srcu_struct_1, and call_srcu() on
-srcu_struct_2(), then the following three lines of code will be required
-when unloading:
+srcu_struct_2, then the following three lines of code will be required
+when unloading::
 
  1 rcu_barrier();
  2 srcu_barrier(&srcu_struct_1);
  3 srcu_barrier(&srcu_struct_2);
 
 The rcutorture module makes use of rcu_barrier() in its exit function
-as follows:
+as follows::
 
- 1 static void
- 2 rcu_torture_cleanup(void)
- 3 {
- 4   int i;
+ 1  static void
+ 2  rcu_torture_cleanup(void)
+ 3  {
+ 4    int i;
  5
- 6   fullstop = 1;
- 7   if (shuffler_task != NULL) {
+ 6    fullstop = 1;
+ 7    if (shuffler_task != NULL) {
  8     VERBOSE_PRINTK_STRING("Stopping rcu_torture_shuffle task");
  9     kthread_stop(shuffler_task);
-10   }
-11   shuffler_task = NULL;
-12
-13   if (writer_task != NULL) {
-14     VERBOSE_PRINTK_STRING("Stopping rcu_torture_writer task");
-15     kthread_stop(writer_task);
-16   }
-17   writer_task = NULL;
-18
-19   if (reader_tasks != NULL) {
-20     for (i = 0; i < nrealreaders; i++) {
-21       if (reader_tasks[i] != NULL) {
-22         VERBOSE_PRINTK_STRING(
-23           "Stopping rcu_torture_reader task");
-24         kthread_stop(reader_tasks[i]);
-25       }
-26       reader_tasks[i] = NULL;
-27     }
-28     kfree(reader_tasks);
-29     reader_tasks = NULL;
-30   }
-31   rcu_torture_current = NULL;
-32
-33   if (fakewriter_tasks != NULL) {
-34     for (i = 0; i < nfakewriters; i++) {
-35       if (fakewriter_tasks[i] != NULL) {
-36         VERBOSE_PRINTK_STRING(
-37           "Stopping rcu_torture_fakewriter task");
-38         kthread_stop(fakewriter_tasks[i]);
-39       }
-40       fakewriter_tasks[i] = NULL;
-41     }
-42     kfree(fakewriter_tasks);
-43     fakewriter_tasks = NULL;
-44   }
-45
-46   if (stats_task != NULL) {
-47     VERBOSE_PRINTK_STRING("Stopping rcu_torture_stats task");
-48     kthread_stop(stats_task);
-49   }
-50   stats_task = NULL;
-51
-52   /* Wait for all RCU callbacks to fire. */
-53   rcu_barrier();
-54
-55   rcu_torture_stats_print(); /* -After- the stats thread is stopped! */
-56
-57   if (cur_ops->cleanup != NULL)
-58     cur_ops->cleanup();
-59   if (atomic_read(&n_rcu_torture_error))
-60     rcu_torture_print_module_parms("End of test: FAILURE");
-61   else
-62     rcu_torture_print_module_parms("End of test: SUCCESS");
-63 }
+ 10   }
+ 11   shuffler_task = NULL;
+ 12
+ 13   if (writer_task != NULL) {
+ 14     VERBOSE_PRINTK_STRING("Stopping rcu_torture_writer task");
+ 15     kthread_stop(writer_task);
+ 16   }
+ 17   writer_task = NULL;
+ 18
+ 19   if (reader_tasks != NULL) {
+ 20     for (i = 0; i < nrealreaders; i++) {
+ 21       if (reader_tasks[i] != NULL) {
+ 22         VERBOSE_PRINTK_STRING(
+ 23           "Stopping rcu_torture_reader task");
+ 24         kthread_stop(reader_tasks[i]);
+ 25       }
+ 26       reader_tasks[i] = NULL;
+ 27     }
+ 28     kfree(reader_tasks);
+ 29     reader_tasks = NULL;
+ 30   }
+ 31   rcu_torture_current = NULL;
+ 32
+ 33   if (fakewriter_tasks != NULL) {
+ 34     for (i = 0; i < nfakewriters; i++) {
+ 35       if (fakewriter_tasks[i] != NULL) {
+ 36         VERBOSE_PRINTK_STRING(
+ 37           "Stopping rcu_torture_fakewriter task");
+ 38         kthread_stop(fakewriter_tasks[i]);
+ 39       }
+ 40       fakewriter_tasks[i] = NULL;
+ 41     }
+ 42     kfree(fakewriter_tasks);
+ 43     fakewriter_tasks = NULL;
+ 44   }
+ 45
+ 46   if (stats_task != NULL) {
+ 47     VERBOSE_PRINTK_STRING("Stopping rcu_torture_stats task");
+ 48     kthread_stop(stats_task);
+ 49   }
+ 50   stats_task = NULL;
+ 51
+ 52   /* Wait for all RCU callbacks to fire. */
+ 53   rcu_barrier();
+ 54
+ 55   rcu_torture_stats_print(); /* -After- the stats thread is stopped! */
+ 56
+ 57   if (cur_ops->cleanup != NULL)
+ 58     cur_ops->cleanup();
+ 59   if (atomic_read(&n_rcu_torture_error))
+ 60     rcu_torture_print_module_parms("End of test: FAILURE");
+ 61   else
+ 62     rcu_torture_print_module_parms("End of test: SUCCESS");
+ 63 }
 
 Line 6 sets a global variable that prevents any RCU callbacks from
 re-posting themselves. This will not be necessary in most cases, since
@@ -176,9 +181,14 @@ for any pre-existing callbacks to complete.
 Then lines 55-62 print status and do operation-specific cleanup, and
 then return, permitting the module-unload operation to be completed.
 
-Quick Quiz #1: Is there any other situation where rcu_barrier() might
+.. _rcubarrier_quiz_1:
+
+Quick Quiz #1:
+	Is there any other situation where rcu_barrier() might
 	be required?
 
+:ref:`Answer to Quick Quiz #1 <answer_rcubarrier_quiz_1>`
+
 Your module might have additional complications. For example, if your
 module invokes call_rcu() from timers, you will need to first cancel all
 the timers, and only then invoke rcu_barrier() to wait for any remaining
@@ -188,11 +198,12 @@ Of course, if you module uses call_rcu(), you will need to invoke
 rcu_barrier() before unloading.  Similarly, if your module uses
 call_srcu(), you will need to invoke srcu_barrier() before unloading,
 and on the same srcu_struct structure.  If your module uses call_rcu()
--and- call_srcu(), then you will need to invoke rcu_barrier() -and-
+**and** call_srcu(), then you will need to invoke rcu_barrier() **and**
 srcu_barrier().
 
 
 Implementing rcu_barrier()
+--------------------------
 
 Dipankar Sarma's implementation of rcu_barrier() makes use of the fact
 that RCU callbacks are never reordered once queued on one of the per-CPU
@@ -200,19 +211,19 @@ queues. His implementation queues an RCU callback on each of the per-CPU
 callback queues, and then waits until they have all started executing, at
 which point, all earlier RCU callbacks are guaranteed to have completed.
 
-The original code for rcu_barrier() was as follows:
+The original code for rcu_barrier() was as follows::
 
- 1 void rcu_barrier(void)
- 2 {
- 3   BUG_ON(in_interrupt());
- 4   /* Take cpucontrol mutex to protect against CPU hotplug */
- 5   mutex_lock(&rcu_barrier_mutex);
- 6   init_completion(&rcu_barrier_completion);
- 7   atomic_set(&rcu_barrier_cpu_count, 0);
- 8   on_each_cpu(rcu_barrier_func, NULL, 0, 1);
- 9   wait_for_completion(&rcu_barrier_completion);
-10   mutex_unlock(&rcu_barrier_mutex);
-11 }
+ 1  void rcu_barrier(void)
+ 2  {
+ 3    BUG_ON(in_interrupt());
+ 4    /* Take cpucontrol mutex to protect against CPU hotplug */
+ 5    mutex_lock(&rcu_barrier_mutex);
+ 6    init_completion(&rcu_barrier_completion);
+ 7    atomic_set(&rcu_barrier_cpu_count, 0);
+ 8    on_each_cpu(rcu_barrier_func, NULL, 0, 1);
+ 9    wait_for_completion(&rcu_barrier_completion);
+ 10   mutex_unlock(&rcu_barrier_mutex);
+ 11 }
 
 Line 3 verifies that the caller is in process context, and lines 5 and 10
 use rcu_barrier_mutex to ensure that only one rcu_barrier() is using the
@@ -226,18 +237,18 @@ This code was rewritten in 2008 and several times thereafter, but this
 still gives the general idea.
 
 The rcu_barrier_func() runs on each CPU, where it invokes call_rcu()
-to post an RCU callback, as follows:
+to post an RCU callback, as follows::
 
- 1 static void rcu_barrier_func(void *notused)
- 2 {
- 3 int cpu = smp_processor_id();
- 4 struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
- 5 struct rcu_head *head;
+ 1  static void rcu_barrier_func(void *notused)
+ 2  {
+ 3    int cpu = smp_processor_id();
+ 4    struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
+ 5    struct rcu_head *head;
  6
- 7 head = &rdp->barrier;
- 8 atomic_inc(&rcu_barrier_cpu_count);
- 9 call_rcu(head, rcu_barrier_callback);
-10 }
+ 7    head = &rdp->barrier;
+ 8    atomic_inc(&rcu_barrier_cpu_count);
+ 9    call_rcu(head, rcu_barrier_callback);
+ 10 }
 
 Lines 3 and 4 locate RCU's internal per-CPU rcu_data structure,
 which contains the struct rcu_head that needed for the later call to
@@ -248,20 +259,25 @@ the current CPU's queue.
 
 The rcu_barrier_callback() function simply atomically decrements the
 rcu_barrier_cpu_count variable and finalizes the completion when it
-reaches zero, as follows:
+reaches zero, as follows::
 
  1 static void rcu_barrier_callback(struct rcu_head *notused)
  2 {
- 3 if (atomic_dec_and_test(&rcu_barrier_cpu_count))
- 4 complete(&rcu_barrier_completion);
+ 3   if (atomic_dec_and_test(&rcu_barrier_cpu_count))
+ 4     complete(&rcu_barrier_completion);
  5 }
 
-Quick Quiz #2: What happens if CPU 0's rcu_barrier_func() executes
+.. _rcubarrier_quiz_2:
+
+Quick Quiz #2:
+	What happens if CPU 0's rcu_barrier_func() executes
 	immediately (thus incrementing rcu_barrier_cpu_count to the
 	value one), but the other CPU's rcu_barrier_func() invocations
 	are delayed for a full grace period? Couldn't this result in
 	rcu_barrier() returning prematurely?
 
+:ref:`Answer to Quick Quiz #2 <answer_rcubarrier_quiz_2>`
+
 The current rcu_barrier() implementation is more complex, due to the need
 to avoid disturbing idle CPUs (especially on battery-powered systems)
 and the need to minimally disturb non-idle CPUs in real-time systems.
@@ -269,6 +285,7 @@ However, the code above illustrates the concepts.
 
 
 rcu_barrier() Summary
+---------------------
 
 The rcu_barrier() primitive has seen relatively little use, since most
 code using RCU is in the core kernel rather than in modules. However, if
@@ -277,8 +294,12 @@ so that your module may be safely unloaded.
 
 
 Answers to Quick Quizzes
+------------------------
+
+.. _answer_rcubarrier_quiz_1:
 
-Quick Quiz #1: Is there any other situation where rcu_barrier() might
+Quick Quiz #1:
+	Is there any other situation where rcu_barrier() might
 	be required?
 
 Answer: Interestingly enough, rcu_barrier() was not originally
@@ -292,7 +313,12 @@ Answer: Interestingly enough, rcu_barrier() was not originally
 	implementing rcutorture, and found that rcu_barrier() solves
 	this problem as well.
 
-Quick Quiz #2: What happens if CPU 0's rcu_barrier_func() executes
+:ref:`Back to Quick Quiz #1 <rcubarrier_quiz_1>`
+
+.. _answer_rcubarrier_quiz_2:
+
+Quick Quiz #2:
+	What happens if CPU 0's rcu_barrier_func() executes
 	immediately (thus incrementing rcu_barrier_cpu_count to the
 	value one), but the other CPU's rcu_barrier_func() invocations
 	are delayed for a full grace period? Couldn't this result in
@@ -323,3 +349,5 @@ Answer: This cannot happen. The reason is that on_each_cpu() has its last
 	is to add an rcu_read_lock() before line 8 of rcu_barrier()
 	and an rcu_read_unlock() after line 8 of this same function. If
 	you can think of a better change, please let me know!
+
+:ref:`Back to Quick Quiz #2 <rcubarrier_quiz_2>`
-- 
2.9.5

