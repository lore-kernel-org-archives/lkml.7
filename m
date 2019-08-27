Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AF9C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F3321872
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 09:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730071AbfH0JgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 05:36:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43062 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbfH0JgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 05:36:23 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i2XtT-0001Am-Qo; Tue, 27 Aug 2019 11:36:03 +0200
Date:   Tue, 27 Aug 2019 11:36:03 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Scott Wood <swood@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: Rename rcu_node_context_switch() to
 rcu_note_context_switch()
Message-ID: <20190827093603.x2dist7q5e2z36c5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While Paul was explaning some RCU magic I noticed a typo in
rcu_note_context_switch().
Replace rcu_node_context_switch() with rcu_note_context_switch().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 .../RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html    | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg         | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
index c64f8d26609fb..54db02b74f636 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
@@ -481,7 +481,7 @@ section that the grace period must wait on.
 </table>
 
 <p>If the CPU does a context switch, a quiescent state will be
-noted by <tt>rcu_node_context_switch()</tt> on the left.
+noted by <tt>rcu_note_context_switch()</tt> on the left.
 On the other hand, if the CPU takes a scheduler-clock interrupt
 while executing in usermode, a quiescent state will be noted by
 <tt>rcu_sched_clock_irq()</tt> on the right.
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
index 2bcd742d6e491..069f6f8371c20 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
@@ -3880,7 +3880,7 @@
          font-style="normal"
          y="-4418.6582"
          x="3745.7725"
-         xml:space="preserve">rcu_node_context_switch()</text>
+         xml:space="preserve">rcu_note_context_switch()</text>
     </g>
     <g
        transform="translate(1881.1886,54048.57)"
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
index 779c9ac31a527..7d6c5f7e505c6 100644
--- a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
+++ b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg
@@ -753,7 +753,7 @@
          font-style="normal"
          y="-4418.6582"
          x="3745.7725"
-         xml:space="preserve">rcu_node_context_switch()</text>
+         xml:space="preserve">rcu_note_context_switch()</text>
     </g>
     <g
        transform="translate(3131.2648,-585.6713)"
-- 
2.23.0

