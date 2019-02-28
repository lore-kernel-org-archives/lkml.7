Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64D8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F3021850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 07:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbfB1HJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 02:09:07 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57027 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731185AbfB1HJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 02:09:07 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1S78ZUG2938881
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 27 Feb 2019 23:08:36 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1S78ZYd2938878;
        Wed, 27 Feb 2019 23:08:35 -0800
Date:   Wed, 27 Feb 2019 23:08:35 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Bart Van Assche <tipbot@zytor.com>
Message-ID: <tip-29fc33fb7283970701355dc89badba4ed21c7092@git.kernel.org>
Cc:     tglx@linutronix.de, bvanassche@acm.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        will.deacon@arm.com, mingo@kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, longman@redhat.com,
        paulmck@linux.vnet.ibm.com, johannes@sipsolutions.net
Reply-To: paulmck@linux.vnet.ibm.com, johannes@sipsolutions.net,
          longman@redhat.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org,
          hpa@zytor.com, tglx@linutronix.de, bvanassche@acm.org,
          torvalds@linux-foundation.org, akpm@linux-foundation.org
In-Reply-To: <20190214230058.196511-11-bvanassche@acm.org>
References: <20190214230058.196511-11-bvanassche@acm.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lockdep: Update two outdated comments
Git-Commit-ID: 29fc33fb7283970701355dc89badba4ed21c7092
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

Commit-ID:  29fc33fb7283970701355dc89badba4ed21c7092
Gitweb:     https://git.kernel.org/tip/29fc33fb7283970701355dc89badba4ed21c7092
Author:     Bart Van Assche <bvanassche@acm.org>
AuthorDate: Thu, 14 Feb 2019 15:00:45 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 28 Feb 2019 07:55:43 +0100

locking/lockdep: Update two outdated comments

synchronize_sched() has been removed recently. Update the comments that
refer to synchronize_sched().

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
Fixes: 51959d85f32d ("lockdep: Replace synchronize_sched() with synchronize_rcu()") # v5.0-rc1
Link: https://lkml.kernel.org/r/20190214230058.196511-11-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lockdep.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 34cd87c65f5d..c7ca3a4def7e 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4188,9 +4188,9 @@ static void __lockdep_free_key_range(void *start, unsigned long size)
  * Used in module.c to remove lock classes from memory that is going to be
  * freed; and possibly re-used by other modules.
  *
- * We will have had one sync_sched() before getting here, so we're guaranteed
- * nobody will look up these exact classes -- they're properly dead but still
- * allocated.
+ * We will have had one synchronize_rcu() before getting here, so we're
+ * guaranteed nobody will look up these exact classes -- they're properly dead
+ * but still allocated.
  */
 void lockdep_free_key_range(void *start, unsigned long size)
 {
@@ -4209,8 +4209,6 @@ void lockdep_free_key_range(void *start, unsigned long size)
 	/*
 	 * Wait for any possible iterators from look_up_lock_class() to pass
 	 * before continuing to free the memory they refer to.
-	 *
-	 * sync_sched() is sufficient because the read-side is IRQ disable.
 	 */
 	synchronize_rcu();
 
