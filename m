Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4127CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4DD92087F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfJaLzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:55:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55397 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727270AbfJaLzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:55:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iQ92p-00034Y-8N; Thu, 31 Oct 2019 12:55:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B24AD1C04F3;
        Thu, 31 Oct 2019 12:55:06 +0100 (CET)
Date:   Thu, 31 Oct 2019 11:55:06 -0000
From:   "tip-bot2 for Alan Stern" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/memory-model/Documentation: Fix typos in
 explanation.txt
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <157252290634.29376.12383526445235828986.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3321ea12907abd477ff7e9bf5f365524b8f1f2fc
Gitweb:        https://git.kernel.org/tip/3321ea12907abd477ff7e9bf5f365524b8f1f2fc
Author:        Alan Stern <stern@rowland.harvard.edu>
AuthorDate:    Tue, 01 Oct 2019 13:39:47 -04:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sat, 05 Oct 2019 11:58:55 -07:00

tools/memory-model/Documentation: Fix typos in explanation.txt

This patch fixes a few minor typos and improves word usage in a few
places in the Linux Kernel Memory Model's explanation.txt file.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Acked-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/explanation.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 488f11f..1b52645 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -206,7 +206,7 @@ goes like this:
 	P0 stores 1 to buf before storing 1 to flag, since it executes
 	its instructions in order.
 
-	Since an instruction (in this case, P1's store to flag) cannot
+	Since an instruction (in this case, P0's store to flag) cannot
 	execute before itself, the specified outcome is impossible.
 
 However, real computer hardware almost never follows the Sequential
@@ -419,7 +419,7 @@ example:
 
 The object code might call f(5) either before or after g(6); the
 memory model cannot assume there is a fixed program order relation
-between them.  (In fact, if the functions are inlined then the
+between them.  (In fact, if the function calls are inlined then the
 compiler might even interleave their object code.)
 
 
@@ -499,7 +499,7 @@ different CPUs (external reads-from, or rfe).
 
 For our purposes, a memory location's initial value is treated as
 though it had been written there by an imaginary initial store that
-executes on a separate CPU before the program runs.
+executes on a separate CPU before the main program runs.
 
 Usage of the rf relation implicitly assumes that loads will always
 read from a single store.  It doesn't apply properly in the presence
@@ -955,7 +955,7 @@ atomic update.  This is what the LKMM's "atomic" axiom says.
 THE PRESERVED PROGRAM ORDER RELATION: ppo
 -----------------------------------------
 
-There are many situations where a CPU is obligated to execute two
+There are many situations where a CPU is obliged to execute two
 instructions in program order.  We amalgamate them into the ppo (for
 "preserved program order") relation, which links the po-earlier
 instruction to the po-later instruction and is thus a sub-relation of
@@ -1572,7 +1572,7 @@ and there are events X, Y and a read-side critical section C such that:
 
 	2. X comes "before" Y in some sense (including rfe, co and fr);
 
-	2. Y is po-before Z;
+	3. Y is po-before Z;
 
 	4. Z is the rcu_read_unlock() event marking the end of C;
 
