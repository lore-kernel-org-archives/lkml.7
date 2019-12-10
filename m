Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7001CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC12205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575950210;
	bh=G557qi1L37NPukYRDvAYGPI238AzuoDvU1ys0NoNy1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=intiXI2xHJ51jM0UxgUcfeROm0JkZIAPTH4jZtOmvFnClAtaIsCXVJ+UrpqRoMpoj
	 XEr5euW/yG+SwHxHGkPOpQyREsUNdlZZaXvryOSzYbegQY59BxNTdv8wA+NlHIXZbq
	 WChXAoZv7dI6KAZMuqFXSu6r+BKcd6wyyM4aNcGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfLJD4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:56:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfLJD4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:56:46 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50D722080D;
        Tue, 10 Dec 2019 03:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575950204;
        bh=G557qi1L37NPukYRDvAYGPI238AzuoDvU1ys0NoNy1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jC/wMRTTIUeYyPQH+64OU4+WrG9o7AEWbPj+cWS96lvH1Hnz8lVrxGCKev7QdwXqV
         LWOWSNsjknlofl1OAcCXC1fhRi9UpS+V3L855CD8qKl0m096+XR8IsXSoy8sPiU2xm
         iSi/099IzTq7fn1VOFGunTgyOz5WyZudXeMMHueY=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 2/7] doc: Converted NMI-RCU.txt to NMI-RCU.rst.
Date:   Mon,  9 Dec 2019 19:56:36 -0800
Message-Id: <20191210035641.2226-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191210035539.GA792@paulmck-ThinkPad-P72>
References: <20191210035539.GA792@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>

This patch converts NMI-RCU from txt to rst format.
Also adds NMI-RCU in the index.rst file.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>
[ paulmck: Apply feedback from Phong Tran. ]
Tested-by: Phong Tran <tranmanphong@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/{NMI-RCU.txt => NMI-RCU.rst} | 53 ++++++++++++++------------
 Documentation/RCU/index.rst                    |  1 +
 2 files changed, 29 insertions(+), 25 deletions(-)
 rename Documentation/RCU/{NMI-RCU.txt => NMI-RCU.rst} (73%)

diff --git a/Documentation/RCU/NMI-RCU.txt b/Documentation/RCU/NMI-RCU.rst
similarity index 73%
rename from Documentation/RCU/NMI-RCU.txt
rename to Documentation/RCU/NMI-RCU.rst
index 881353f..1809583 100644
--- a/Documentation/RCU/NMI-RCU.txt
+++ b/Documentation/RCU/NMI-RCU.rst
@@ -1,4 +1,7 @@
+.. _NMI_rcu_doc:
+
 Using RCU to Protect Dynamic NMI Handlers
+=========================================
 
 
 Although RCU is usually used to protect read-mostly data structures,
@@ -9,7 +12,7 @@ work in "arch/x86/oprofile/nmi_timer_int.c" and in
 "arch/x86/kernel/traps.c".
 
 The relevant pieces of code are listed below, each followed by a
-brief explanation.
+brief explanation::
 
 	static int dummy_nmi_callback(struct pt_regs *regs, int cpu)
 	{
@@ -18,12 +21,12 @@ brief explanation.
 
 The dummy_nmi_callback() function is a "dummy" NMI handler that does
 nothing, but returns zero, thus saying that it did nothing, allowing
-the NMI handler to take the default machine-specific action.
+the NMI handler to take the default machine-specific action::
 
 	static nmi_callback_t nmi_callback = dummy_nmi_callback;
 
 This nmi_callback variable is a global function pointer to the current
-NMI handler.
+NMI handler::
 
 	void do_nmi(struct pt_regs * regs, long error_code)
 	{
@@ -53,11 +56,12 @@ anyway.  However, in practice it is a good documentation aid, particularly
 for anyone attempting to do something similar on Alpha or on systems
 with aggressive optimizing compilers.
 
-Quick Quiz:  Why might the rcu_dereference_sched() be necessary on Alpha,
-	     given that the code referenced by the pointer is read-only?
+Quick Quiz:
+		Why might the rcu_dereference_sched() be necessary on Alpha, given that the code referenced by the pointer is read-only?
 
+:ref:`Answer to Quick Quiz <answer_quick_quiz_NMI>`
 
-Back to the discussion of NMI and RCU...
+Back to the discussion of NMI and RCU::
 
 	void set_nmi_callback(nmi_callback_t callback)
 	{
@@ -68,7 +72,7 @@ The set_nmi_callback() function registers an NMI handler.  Note that any
 data that is to be used by the callback must be initialized up -before-
 the call to set_nmi_callback().  On architectures that do not order
 writes, the rcu_assign_pointer() ensures that the NMI handler sees the
-initialized values.
+initialized values::
 
 	void unset_nmi_callback(void)
 	{
@@ -82,7 +86,7 @@ up any data structures used by the old NMI handler until execution
 of it completes on all other CPUs.
 
 One way to accomplish this is via synchronize_rcu(), perhaps as
-follows:
+follows::
 
 	unset_nmi_callback();
 	synchronize_rcu();
@@ -98,24 +102,23 @@ to free up the handler's data as soon as synchronize_rcu() returns.
 Important note: for this to work, the architecture in question must
 invoke nmi_enter() and nmi_exit() on NMI entry and exit, respectively.
 
+.. _answer_quick_quiz_NMI:
 
-Answer to Quick Quiz
-
-	Why might the rcu_dereference_sched() be necessary on Alpha, given
-	that the code referenced by the pointer is read-only?
+Answer to Quick Quiz:
+	Why might the rcu_dereference_sched() be necessary on Alpha, given that the code referenced by the pointer is read-only?
 
-	Answer: The caller to set_nmi_callback() might well have
-		initialized some data that is to be used by the new NMI
-		handler.  In this case, the rcu_dereference_sched() would
-		be needed, because otherwise a CPU that received an NMI
-		just after the new handler was set might see the pointer
-		to the new NMI handler, but the old pre-initialized
-		version of the handler's data.
+	The caller to set_nmi_callback() might well have
+	initialized some data that is to be used by the new NMI
+	handler.  In this case, the rcu_dereference_sched() would
+	be needed, because otherwise a CPU that received an NMI
+	just after the new handler was set might see the pointer
+	to the new NMI handler, but the old pre-initialized
+	version of the handler's data.
 
-		This same sad story can happen on other CPUs when using
-		a compiler with aggressive pointer-value speculation
-		optimizations.
+	This same sad story can happen on other CPUs when using
+	a compiler with aggressive pointer-value speculation
+	optimizations.
 
-		More important, the rcu_dereference_sched() makes it
-		clear to someone reading the code that the pointer is
-		being protected by RCU-sched.
+	More important, the rcu_dereference_sched() makes it
+	clear to someone reading the code that the pointer is
+	being protected by RCU-sched.
diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 8d20d44..627128c 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -10,6 +10,7 @@ RCU concepts
    arrayRCU
    rcu
    listRCU
+   NMI-RCU
    UP
 
    Design/Memory-Ordering/Tree-RCU-Memory-Ordering
-- 
2.9.5

