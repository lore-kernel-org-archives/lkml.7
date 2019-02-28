Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119C6C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF56021850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbfB1HLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:11:42 -0500
Received: from terminus.zytor.com ([198.137.202.136]:41933 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbfB1HLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:11:41 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S7BCTT2939434
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:11:12 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S7BBMj2939431;
        Wed, 27 Feb 2019 23:11:11 -0800
Date:   Wed, 27 Feb 2019 23:11:11 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-527af3ea273b2cf0c017a2c90090b3c94af8aba4@git.kernel.org>
Cc:     peterz@infradead.org, johannes@sipsolutions.net,
        bvanassche@acm.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, paulmck@linux.vnet.ibm.com,
        tglx@linutronix.de, longman@redhat.com, akpm@linux-foundation.org,
        mingo@kernel.org, will.deacon@arm.com, hpa@zytor.com
Reply-To: paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org,
          johannes@sipsolutions.net, peterz@infradead.org,
          linux-kernel@vger.kernel.org, bvanassche@acm.org, hpa@zytor.com,
          tglx@linutronix.de, akpm@linux-foundation.org,
          longman@redhat.com, will.deacon@arm.com, mingo@kernel.org
In-Reply-To: <20190214230058.196511-15-bvanassche@acm.org>
References: <20190214230058.196511-15-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Fix a comment in
 add_chain_cache()
Git-Commit-ID: 527af3ea273b2cf0c017a2c90090b3c94af8aba4
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

Commit-ID:  527af3ea273b2cf0c017a2c90090b3c94af8aba4
Gitweb:     https://git.kernel.org/tip/527af3ea273b2cf0c017a2c90090b3c94af8aba4
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 14 Feb 2019 15:00:49 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Feb 2019 07:55:45 +0100

locking/lockdep: Fix a comment in add_chain_cache()

Reflect that add_chain_cache() is always called with the graph lock held.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: johannes.berg@intel.com
Cc: tj@kernel.org
Link: https://lkml.kernel.org/r/20190214230058.196511-15-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 753a9b758266..ec0cb794f70d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2266,7 +2266,7 @@ static inline int add_chain_cache(struct task_struct *curr,
 	 */
 
 	/*
-	 * We might need to take the graph lock, ensure we've got IRQs
+	 * The caller must hold the graph lock, ensure we've got IRQs
 	 * disabled to make this an IRQ-safe lock.. for recursion reasons
 	 * lockdep won't complain about its own locking errors.
 	 */
