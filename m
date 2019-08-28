Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B19C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BA922CF5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfH1LDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 07:03:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46717 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfH1LDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 07:03:37 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i2vjh-0001SL-Ql; Wed, 28 Aug 2019 13:03:34 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 64E2A1C07D2;
        Wed, 28 Aug 2019 13:03:33 +0200 (CEST)
Date:   Wed, 28 Aug 2019 11:03:33 -0000
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Add kernel doc annotation for HRTIMER_MODE_HARD
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190823113845.12125-2-bigeasy@linutronix.de>
References: <20190823113845.12125-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <156699021323.13471.2791153356668392865.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a67e408241783575716fcf3f79d0878f6cef0273
Gitweb:        https://git.kernel.org/tip/a67e408241783575716fcf3f79d0878f6cef0273
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Fri, 23 Aug 2019 13:38:44 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Aug 2019 13:01:25 +02:00

hrtimer: Add kernel doc annotation for HRTIMER_MODE_HARD

Add kernel doc annotation for HRTIMER_MODE_HARD.

Fixes: ae6683d815895 ("hrtimer: Introduce HARD expiry mode")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190823113845.12125-2-bigeasy@linutronix.de

---
 include/linux/hrtimer.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 5df4bcf..1b9a51a 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -32,6 +32,8 @@ struct hrtimer_cpu_base;
  *				  when starting the timer)
  * HRTIMER_MODE_SOFT		- Timer callback function will be executed in
  *				  soft irq context
+ * HRTIMER_MODE_HARD		- Timer callback function will be executed in
+ *				  hard irq context even on PREEMPT_RT.
  */
 enum hrtimer_mode {
 	HRTIMER_MODE_ABS	= 0x00,
