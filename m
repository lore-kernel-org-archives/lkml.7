Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2112EC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 14:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018F420709
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 14:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfLHO6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 09:58:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36831 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfLHO6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 09:58:49 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1idy1C-0000bz-4d; Sun, 08 Dec 2019 15:58:42 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EC84E1C2889;
        Sun,  8 Dec 2019 15:58:34 +0100 (CET)
Date:   Sun, 08 Dec 2019 14:58:34 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt, c6x: Use CONFIG_PREEMPTION
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Salter <msalter@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-c6x-dev@linux-c6x.org, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191015191821.11479-6-bigeasy@linutronix.de>
References: <20191015191821.11479-6-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <157581711483.21853.1397806174508339513.tip-bot2@tip-bot2>
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

Commit-ID:     51466979c754d11e1e8da0e46a66218ffc7226ee
Gitweb:        https://git.kernel.org/tip/51466979c754d11e1e8da0e46a66218ffc7226ee
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 15 Oct 2019 21:17:52 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 14:37:32 +01:00

sched/rt, c6x: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the entry code over to use CONFIG_PREEMPTION.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Salter <msalter@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-c6x-dev@linux-c6x.org
Link: https://lore.kernel.org/r/20191015191821.11479-6-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/c6x/kernel/entry.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/c6x/kernel/entry.S b/arch/c6x/kernel/entry.S
index 4332a10..fb154d1 100644
--- a/arch/c6x/kernel/entry.S
+++ b/arch/c6x/kernel/entry.S
@@ -18,7 +18,7 @@
 #define DP	B14
 #define SP	B15
 
-#ifndef CONFIG_PREEMPT
+#ifndef CONFIG_PREEMPTION
 #define resume_kernel restore_all
 #endif
 
@@ -287,7 +287,7 @@ work_notifysig:
 	;; is a little bit different
 	;;
 ENTRY(ret_from_exception)
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	MASK_INT B2
 #endif
 
@@ -557,7 +557,7 @@ ENDPROC(_nmi_handler)
 	;;
 	;; Jump to schedule() then return to ret_from_isr
 	;;
-#ifdef	CONFIG_PREEMPT
+#ifdef	CONFIG_PREEMPTION
 resume_kernel:
 	GET_THREAD_INFO A12
 	LDW	.D1T1	*+A12(THREAD_INFO_PREEMPT_COUNT),A1
@@ -582,7 +582,7 @@ preempt_schedule:
 	B	.S2	preempt_schedule_irq
 #endif
 	ADDKPC	.S2	preempt_schedule,B3,4
-#endif /* CONFIG_PREEMPT */
+#endif /* CONFIG_PREEMPTION */
 
 ENTRY(enable_exception)
 	DINT
