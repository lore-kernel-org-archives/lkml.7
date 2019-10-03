Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E90EC4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2566621A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 01:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570066115;
	bh=1oxtnqcyc0aQduAT7zIp0CCwaXuzoorNsS63/IorYpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ct8G3hzH/i4uRxrPZwmBVG072PIS5OIaPU8wuG56J7Iuym0ZR7mdVVVaujFVWjvQ8
	 OBX0C7jabDmAi8p30V8qbWmX01nSj+HepyOP7j0d3YWo5j4cDqSEm31gJep3r9/CdP
	 MfOS5QHy3YD9vBZM1EeRxk9vDsv8pe2YDE20DiS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbfJCB2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 21:28:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727613AbfJCB2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:28:23 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D2A3222C8;
        Thu,  3 Oct 2019 01:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570066102;
        bh=1oxtnqcyc0aQduAT7zIp0CCwaXuzoorNsS63/IorYpo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Edmf4+xyn+tZPsl8zPtl1E0W4iuoLLxn8D+tmKu1FgBNIfyuVk5vJiRV4oKAyhdh5
         zb6TucHOptFrROb84xt78VsOIw4yzaYzks18dZXgBKT4fSzfxGHGjY+h2BDr+PjwB8
         J0bbYKMmlZz4Vk+t8NEV0pbYQT00JmotEdZ1g8E8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 9/9] Documentation: Rename rcu_node_context_switch() to rcu_note_context_switch()
Date:   Wed,  2 Oct 2019 18:28:15 -0700
Message-Id: <20191003012815.12639-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003012741.GA12456@paulmck-ThinkPad-P72>
References: <20191003012741.GA12456@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

While Paul was explaining some RCU magic I noticed a typo in
rcu_note_context_switch().  As a result, this commit replaces
rcu_node_context_switch() with rcu_note_context_switch().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg               | 2 +-
 Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
index 248b1222..1a8b129 100644
--- a/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
+++ b/Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst
@@ -423,7 +423,7 @@ wait on.
 +-----------------------------------------------------------------------+
 
 If the CPU does a context switch, a quiescent state will be noted by
-``rcu_node_context_switch()`` on the left. On the other hand, if the CPU
+``rcu_note_context_switch()`` on the left. On the other hand, if the CPU
 takes a scheduler-clock interrupt while executing in usermode, a
 quiescent state will be noted by ``rcu_sched_clock_irq()`` on the right.
 Either way, the passage through a quiescent state will be noted in a
diff --git a/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg
index 2bcd742..069f6f8 100644
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
index 779c9ac..7d6c5f7 100644
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
2.9.5

