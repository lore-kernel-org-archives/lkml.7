Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BEFC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4A9D20872
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389641AbfJOTUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:20:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45689 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389429AbfJOTSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:18:47 -0400
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iKSLE-00067i-Rw; Tue, 15 Oct 2019 21:18:45 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 32/34] lib: Use CONFIG_PREEMPTION
Date:   Tue, 15 Oct 2019 21:18:19 +0200
Message-Id: <20191015191821.11479-33-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-1-bigeasy@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Let DEBUG_PREEMPT depend on CONFIG_PREEMPTION.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 93d97f9b01571..5aa5c9b263afa 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1053,7 +1053,7 @@ config DEBUG_TIMEKEEPING
=20
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
-	depends on DEBUG_KERNEL && PREEMPT && TRACE_IRQFLAGS_SUPPORT
+	depends on DEBUG_KERNEL && PREEMPTION && TRACE_IRQFLAGS_SUPPORT
 	default y
 	help
 	  If you say Y here then the kernel will use a debug variant of the
--=20
2.23.0

