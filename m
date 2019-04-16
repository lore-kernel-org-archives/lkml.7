Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5E0C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A766F206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 10:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfDPKHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 06:07:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49943 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfDPKHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 06:07:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3GA6qZl3401018
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 16 Apr 2019 03:06:52 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3GA6pEV3401014;
        Tue, 16 Apr 2019 03:06:51 -0700
Date:   Tue, 16 Apr 2019 03:06:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Waiman Long <tipbot@zytor.com>
Message-ID: <tip-bf20616f46e536fe8affed6f138db4b3040b55a6@git.kernel.org>
Cc:     tim.c.chen@linux.intel.com, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com,
        akpm@linux-foundation.org, arnd@arndb.de,
        torvalds@linux-foundation.org, dbueso@suse.de,
        peterz@infradead.org, longman@redhat.com, bp@alien8.de,
        hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
        a.p.zijlstra@chello.nl, will.deacon@arm.com
Reply-To: paulmck@linux.vnet.ibm.com, akpm@linux-foundation.org,
          arnd@arndb.de, torvalds@linux-foundation.org, dbueso@suse.de,
          tim.c.chen@linux.intel.com, dave@stgolabs.net,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tglx@linutronix.de, will.deacon@arm.com, a.p.zijlstra@chello.nl,
          peterz@infradead.org, longman@redhat.com, bp@alien8.de,
          hpa@zytor.com
In-Reply-To: <20190404174320.22416-10-longman@redhat.com>
References: <20190404174320.22416-10-longman@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/lock_events: Don't show pvqspinlock
 events on bare metal
Git-Commit-ID: bf20616f46e536fe8affed6f138db4b3040b55a6
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

Commit-ID:  bf20616f46e536fe8affed6f138db4b3040b55a6
Gitweb:     https://git.kernel.org/tip/bf20616f46e536fe8affed6f138db4b3040b55a6
Author:     Waiman Long <longman@redhat.com>
AuthorDate: Thu, 4 Apr 2019 13:43:18 -0400
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 10 Apr 2019 10:56:05 +0200

locking/lock_events: Don't show pvqspinlock events on bare metal

On bare metal, the pvqspinlock event counts will always be 0. So there
is no point in showing their corresponding debugfs files. So they are
skipped in this case.

Signed-off-by: Waiman Long <longman@redhat.com>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
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
Cc: Will Deacon <will.deacon@arm.com>
Link: http://lkml.kernel.org/r/20190404174320.22416-10-longman@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/locking/lock_events.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lock_events.c b/kernel/locking/lock_events.c
index 71c36d1fb834..fa2c2f951c6b 100644
--- a/kernel/locking/lock_events.c
+++ b/kernel/locking/lock_events.c
@@ -115,6 +115,29 @@ static const struct file_operations fops_lockevent = {
 	.llseek = default_llseek,
 };
 
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#include <asm/paravirt.h>
+
+static bool __init skip_lockevent(const char *name)
+{
+	static int pv_on __initdata = -1;
+
+	if (pv_on < 0)
+		pv_on = !pv_is_native_spin_unlock();
+	/*
+	 * Skip PV qspinlock events on bare metal.
+	 */
+	if (!pv_on && !memcmp(name, "pv_", 3))
+		return true;
+	return false;
+}
+#else
+static inline bool skip_lockevent(const char *name)
+{
+	return false;
+}
+#endif
+
 /*
  * Initialize debugfs for the locking event counts.
  */
@@ -133,10 +156,13 @@ static int __init init_lockevent_counts(void)
 	 * root is allowed to do the read/write to limit impact to system
 	 * performance.
 	 */
-	for (i = 0; i < lockevent_num; i++)
+	for (i = 0; i < lockevent_num; i++) {
+		if (skip_lockevent(lockevent_names[i]))
+			continue;
 		if (!debugfs_create_file(lockevent_names[i], 0400, d_counts,
 					 (void *)(long)i, &fops_lockevent))
 			goto fail_undo;
+	}
 
 	if (!debugfs_create_file(lockevent_names[LOCKEVENT_reset_cnts], 0200,
 				 d_counts, (void *)(long)LOCKEVENT_reset_cnts,
