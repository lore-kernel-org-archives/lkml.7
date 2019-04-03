Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B816C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CAA2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfDCKtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:49:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51859 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfDCKtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:49:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x33AmvN71815516
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 3 Apr 2019 03:48:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x33Amvii1815513;
        Wed, 3 Apr 2019 03:48:57 -0700
Date:   Wed, 3 Apr 2019 03:48:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for YueHaibing <tipbot@zytor.com>
Message-ID: <tip-71b47eaf6fb29b7f9722dc1646c26eb8a96e0a6d@git.kernel.org>
Cc:     efault@gmx.de, torvalds@linux-foundation.org,
        yuehaibing@huawei.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@kernel.org, hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, peterz@infradead.org,
          hpa@zytor.com, mingo@kernel.org, efault@gmx.de,
          yuehaibing@huawei.com, tglx@linutronix.de,
          torvalds@linux-foundation.org
In-Reply-To: <20190320133839.21392-1-yuehaibing@huawei.com>
References: <20190320133839.21392-1-yuehaibing@huawei.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Make sync_entity_load_avg() and
 remove_entity_load_avg() static
Git-Commit-ID: 71b47eaf6fb29b7f9722dc1646c26eb8a96e0a6d
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

Commit-ID:  71b47eaf6fb29b7f9722dc1646c26eb8a96e0a6d
Gitweb:     https://git.kernel.org/tip/71b47eaf6fb29b7f9722dc1646c26eb8a96e0a6d
Author:     YueHaibing <yuehaibing@huawei.com>
AuthorDate: Wed, 20 Mar 2019 21:38:39 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 3 Apr 2019 12:34:31 +0200

sched/fair: Make sync_entity_load_avg() and remove_entity_load_avg() static

Fix these sparse warnigs:

  kernel/sched/fair.c:3570:6: warning: symbol 'sync_entity_load_avg' was not declared. Should it be static?
  kernel/sched/fair.c:3583:6: warning: symbol 'remove_entity_load_avg' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190320133839.21392-1-yuehaibing@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 40bd1e27b1b7..ed7f5f8107b7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3567,7 +3567,7 @@ static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
  * Synchronize entity load avg of dequeued entity without locking
  * the previous rq.
  */
-void sync_entity_load_avg(struct sched_entity *se)
+static void sync_entity_load_avg(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	u64 last_update_time;
@@ -3580,7 +3580,7 @@ void sync_entity_load_avg(struct sched_entity *se)
  * Task first catches up with cfs_rq, and then subtract
  * itself from the cfs_rq (task must be off the queue now).
  */
-void remove_entity_load_avg(struct sched_entity *se)
+static void remove_entity_load_avg(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 	unsigned long flags;
