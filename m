Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95981C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B8022CEC
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 11:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392914AbfHWLix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 07:38:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34973 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbfHWLiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 07:38:51 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i17u5-00010K-3n; Fri, 23 Aug 2019 13:38:49 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/2] hrtimer: Add kernel doc annotation for HRTIMER_MODE_HARD
Date:   Fri, 23 Aug 2019 13:38:44 +0200
Message-Id: <20190823113845.12125-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823113845.12125-1-bigeasy@linutronix.de>
References: <20190823113845.12125-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add kernel doc annotation for HRTIMER_MODE_HARD.
This should have been part of commit
  ae6683d815895 ("hrtimer: Introduce HARD expiry mode")

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/hrtimer.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 5df4bcff96d58..1b9a51a1bccb7 100644
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
 	HRTIMER_MODE_ABS	=3D 0x00,
--=20
2.23.0

