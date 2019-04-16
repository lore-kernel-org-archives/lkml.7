Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3AFC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2694B206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfDPKFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:05:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55435 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfDPKFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:05:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GA2XWo3398567
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 03:02:33 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GA2XaQ3398562;
        Tue, 16 Apr 2019 03:02:33 -0700
Date:   Tue, 16 Apr 2019 03:02:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-12a30a7fc142a123c61da9623bd824d95d36c12e@git.kernel.org>
Cc:     will.deacon@arm.com, bp@alien8.de, tglx@linutronix.de,
        longman@redhat.com, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, a.p.zijlstra@chello.nl,
        peterz@infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        paulmck@linux.vnet.ibm.com, tim.c.chen@linux.intel.com,
        dave@stgolabs.net, arnd@arndb.de, dbueso@suse.de, mingo@kernel.org
Reply-To: will.deacon@arm.com, bp@alien8.de, longman@redhat.com,
          tglx@linutronix.de, torvalds@linux-foundation.org,
          akpm@linux-foundation.org, a.p.zijlstra@chello.nl,
          peterz@infradead.org, linux-kernel@vger.kernel.org,
          hpa@zytor.com, paulmck@linux.vnet.ibm.com,
          tim.c.chen@linux.intel.com, dave@stgolabs.net, dbueso@suse.de,
          arnd@arndb.de, mingo@kernel.org
In-Reply-To: <20190404174320.22416-4-longman@redhat.com>
References: <20190404174320.22416-4-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/rwsem: Move rwsem internal function
 declarations to rwsem-xadd.h
Git-Commit-ID: 12a30a7fc142a123c61da9623bd824d95d36c12e
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

Commit-ID:  12a30a7fc142a123c61da9623bd824d95d36c12e
Gitweb:     https://git.kernel.org/tip/12a30a7fc142a123c61da9623bd824d95d36c12e
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Thu, 4 Apr 2019 13:43:12 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 10 Apr 2019 10:56:00 +0200

locking/rwsem: Move rwsem internal function declarations to rwsem-xadd.h

We don't need to expose rwsem internal functions which are not supposed
to be called directly from other kernel code.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Acked-by: Will Deacon <will.deacon@arm.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Link: http://lkml.kernel.org/r/20190404174320.22416-4-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/rwsem.h  | 7 -------
 kernel/locking/rwsem.h | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 0fc41062c649..b44e533235c7 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -46,13 +46,6 @@ struct rw_semaphore {
  */
 #define RWSEM_OWNER_UNKNOWN	((struct task_struct *)-2L)
 
-extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_read_failed_killable(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_down_write_failed_killable(struct rw_semaphore *sem);
-extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *);
-extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
-
 /* In all implementations count != 0 means locked */
 static inline int rwsem_is_locked(struct rw_semaphore *sem)
 {
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index ee24c4f257a5..19997c82270b 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -153,6 +153,13 @@ static inline void rwsem_clear_reader_owned(struct rw_semaphore *sem)
 }
 #endif
 
+extern struct rw_semaphore *rwsem_down_read_failed(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_down_read_failed_killable(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_down_write_failed(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_down_write_failed_killable(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem);
+extern struct rw_semaphore *rwsem_downgrade_wake(struct rw_semaphore *sem);
+
 /*
  * lock for reading
  */
