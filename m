Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27A7C2D0BE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 14:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B6F220722
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 14:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLHO6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 09:58:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36781 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfLHO6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 09:58:45 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1idy16-0000WP-7w; Sun, 08 Dec 2019 15:58:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C319D1C2885;
        Sun,  8 Dec 2019 15:58:32 +0100 (CET)
Date:   Sun, 08 Dec 2019 14:58:32 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt, parisc: Use CONFIG_PREEMPTION
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-parisc@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191015191821.11479-16-bigeasy@linutronix.de>
References: <20191015191821.11479-16-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <157581711266.21853.13003813137013747981.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     09613e8320cda150717126ba88c0ddc38bfc0c68
Gitweb:        https://git.kernel.org/tip/09613e8320cda150717126ba88c0ddc38bfc0c68
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 15 Oct 2019 21:18:02 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 14:37:34 +01:00

sched/rt, parisc: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the entry code over to use CONFIG_PREEMPTION.

[bigeasy: +Kconfig]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-parisc@vger.kernel.org
Link: https://lore.kernel.org/r/20191015191821.11479-16-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/parisc/Kconfig        |  2 +-
 arch/parisc/kernel/entry.S | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index b16237c..593e401 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -81,7 +81,7 @@ config STACK_GROWSUP
 config GENERIC_LOCKBREAK
 	bool
 	default y
-	depends on SMP && PREEMPT
+	depends on SMP && PREEMPTION
 
 config ARCH_HAS_ILOG2_U32
 	bool
diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
index b96d744..9a03e29 100644
--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -940,14 +940,14 @@ intr_restore:
 	rfi
 	nop
 
-#ifndef CONFIG_PREEMPT
+#ifndef CONFIG_PREEMPTION
 # define intr_do_preempt	intr_restore
-#endif /* !CONFIG_PREEMPT */
+#endif /* !CONFIG_PREEMPTION */
 
 	.import schedule,code
 intr_do_resched:
 	/* Only call schedule on return to userspace. If we're returning
-	 * to kernel space, we may schedule if CONFIG_PREEMPT, otherwise
+	 * to kernel space, we may schedule if CONFIG_PREEMPTION, otherwise
 	 * we jump back to intr_restore.
 	 */
 	LDREG	PT_IASQ0(%r16), %r20
@@ -979,7 +979,7 @@ intr_do_resched:
 	 * and preempt_count is 0. otherwise, we continue on
 	 * our merry way back to the current running task.
 	 */
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	.import preempt_schedule_irq,code
 intr_do_preempt:
 	rsm	PSW_SM_I, %r0		/* disable interrupts */
@@ -999,7 +999,7 @@ intr_do_preempt:
 	nop
 
 	b,n	intr_restore		/* ssm PSW_SM_I done by intr_restore */
-#endif /* CONFIG_PREEMPT */
+#endif /* CONFIG_PREEMPTION */
 
 	/*
 	 * External interrupts.
