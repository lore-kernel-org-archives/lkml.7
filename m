Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F359C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E998120674
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 10:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfKLKid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 05:38:33 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33229 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfKLKid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 05:38:33 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUTZ5-0007x6-Vm; Tue, 12 Nov 2019 11:38:28 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9395C1C0084;
        Tue, 12 Nov 2019 11:38:27 +0100 (CET)
Date:   Tue, 12 Nov 2019 10:38:27 -0000
From:   "tip-bot2 for Srivatsa S. Bhat (VMware)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/rt] sched/Kconfig: Fix spelling mistake in user-visible help text
Cc:     "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <157204450499.10518.4542293884417101528.stgit@srivatsa-ubuntu>
References: <157204450499.10518.4542293884417101528.stgit@srivatsa-ubuntu>
MIME-Version: 1.0
Message-ID: <157355510713.29376.14082067648105582008.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/rt branch of tip:

Commit-ID:     d61ca3c25e0330c44d9a18b2a767197f10c0cd16
Gitweb:        https://git.kernel.org/tip/d61ca3c25e0330c44d9a18b2a767197f10c0cd16
Author:        Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
AuthorDate:    Fri, 25 Oct 2019 16:02:07 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Nov 2019 11:35:32 +01:00

sched/Kconfig: Fix spelling mistake in user-visible help text

Fix a spelling mistake in the help text for PREEMPT_RT.

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/157204450499.10518.4542293884417101528.stgit@srivatsa-ubuntu

---
 kernel/Kconfig.preempt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index deff972..bf82259 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -65,7 +65,7 @@ config PREEMPT_RT
 	  preemptible priority-inheritance aware variants, enforcing
 	  interrupt threading and introducing mechanisms to break up long
 	  non-preemptible sections. This makes the kernel, except for very
-	  low level and critical code pathes (entry code, scheduler, low
+	  low level and critical code paths (entry code, scheduler, low
 	  level interrupt handling) fully preemptible and brings most
 	  execution contexts under scheduler control.
 
