Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D61C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1502F26907
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HRJuBQt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfFCNQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:16:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45233 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbfFCNQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:16:45 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DGZgE606158
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:16:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DGZgE606158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559567795;
        bh=e87xoz9o91NBYY9SFCrF48s6+u3zh4Ck7aL70Yo0Hdo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=HRJuBQt6CfKDwe35SzLK5MQtBbQIQeK830cFPwJ9sutQzFAEh/xA9Yf/KkVHYgKTM
         7GPunpUoL9ihSESb3Xl4vz65eZizwA32eCNsvPmV/iXt/JVi5UVQoYmKKQoPtrR4f8
         Mq4fNy4c07fxdc2IaVykTg0AO3bbCMr5J+Sx+aJ6IxiRmPcliUCAAHm9BfWkhWPLBz
         GcsmAloXpBD2TywtQgaeKRvkKFbQ7rpJPJqphvgOeQ+P5WxmVZERebx+HjrD/4Y1Yk
         dK2E/l8RknZRheOJXRF4p334rx2JtMFnUgcarB20rjRjxvGv4lj8FF9seeFFgLp3Jr
         xB0mrrcJQjL0A==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DGYr9606155;
        Mon, 3 Jun 2019 06:16:34 -0700
Date:   Mon, 3 Jun 2019 06:16:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yuyang Du <tipbot@zytor.com>
Message-ID: <tip-154f185e9c0f6c50ac8e901630e14aa5b36f9414@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, duyuyang@gmail.com,
        mingo@kernel.org, peterz@infradead.org
Reply-To: duyuyang@gmail.com, mingo@kernel.org, peterz@infradead.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
          torvalds@linux-foundation.org
In-Reply-To: <20190506081939.74287-16-duyuyang@gmail.com>
References: <20190506081939.74287-16-duyuyang@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Update comments on dependency
 search
Git-Commit-ID: 154f185e9c0f6c50ac8e901630e14aa5b36f9414
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  154f185e9c0f6c50ac8e901630e14aa5b36f9414
Gitweb:     https://git.kernel.org/tip/154f185e9c0f6c50ac8e901630e14aa5b36f9414
Author:     Yuyang Du <duyuyang@gmail.com>
AuthorDate: Mon, 6 May 2019 16:19:31 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 11:55:47 +0200

locking/lockdep: Update comments on dependency search

The breadth-first search is implemented as flat-out non-recursive now, but
the comments are still describing it as recursive, update the comments in
that regard.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bvanassche@acm.org
Cc: frederic@kernel.org
Cc: ming.lei@redhat.com
Cc: will.deacon@arm.com
Link: https://lkml.kernel.org/r/20190506081939.74287-16-duyuyang@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2e8ef6082f72..b2ca20aa69aa 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1381,6 +1381,10 @@ static inline struct list_head *get_dep_list(struct lock_list *lock, int offset)
 	return lock_class + offset;
 }
 
+/*
+ * Forward- or backward-dependency search, used for both circular dependency
+ * checking and hardirq-unsafe/softirq-unsafe checking.
+ */
 static int __bfs(struct lock_list *source_entry,
 		 void *data,
 		 int (*match)(struct lock_list *entry, void *data),
@@ -1461,12 +1465,6 @@ static inline int __bfs_backwards(struct lock_list *src_entry,
 
 }
 
-/*
- * Recursive, forwards-direction lock-dependency checking, used for
- * both noncyclic checking and for hardirq-unsafe/softirq-unsafe
- * checking.
- */
-
 static void print_lock_trace(struct lock_trace *trace, unsigned int spaces)
 {
 	unsigned long *entries = stack_trace + trace->offset;
@@ -2285,7 +2283,7 @@ check_deadlock(struct task_struct *curr, struct held_lock *next, int read)
 
 /*
  * There was a chain-cache miss, and we are about to add a new dependency
- * to a previous lock. We recursively validate the following rules:
+ * to a previous lock. We validate the following rules:
  *
  *  - would the adding of the <prev> -> <next> dependency create a
  *    circular dependency in the graph? [== circular deadlock]
@@ -2335,11 +2333,12 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 	/*
 	 * Prove that the new <prev> -> <next> dependency would not
 	 * create a circular dependency in the graph. (We do this by
-	 * forward-recursing into the graph starting at <next>, and
-	 * checking whether we can reach <prev>.)
+	 * a breadth-first search into the graph starting at <next>,
+	 * and check whether we can reach <prev>.)
 	 *
-	 * We are using global variables to control the recursion, to
-	 * keep the stackframe size of the recursive functions low:
+	 * The search is limited by the size of the circular queue (i.e.,
+	 * MAX_CIRCULAR_QUEUE_SIZE) which keeps track of a breadth of nodes
+	 * in the graph whose neighbours are to be checked.
 	 */
 	this.class = hlock_class(next);
 	this.parent = NULL;
