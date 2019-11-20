Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3070C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935482243F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfKTKup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:50:45 -0500
Received: from snd00011.auone-net.jp ([111.86.247.11]:17771 "EHLO
        dmta0006-f.auone-net.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727514AbfKTKup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:50:45 -0500
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Nov 2019 05:50:44 EST
Received: from ppp.dion.ne.jp by dmta0009.auone-net.jp with ESMTP
          id <20191120104350753.EWCT.12796.ppp.dion.ne.jp@dmta0009.auone-net.jp>;
          Wed, 20 Nov 2019 19:43:50 +0900
Date:   Wed, 20 Nov 2019 19:43:50 +0900
From:   Kusanagi Kouichi <slash@ac.auone-net.jp>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Remove unnecessary DEBUG_FS dependency
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Message-Id: <20191120104350753.EWCT.12796.ppp.dion.ne.jp@dmta0009.auone-net.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tracing replaced debugfs with tracefs.

Signed-off-by: Kusanagi Kouichi <slash@ac.auone-net.jp>
---
 kernel/trace/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e08527f50d2a..382628b9b759 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -106,7 +106,6 @@ config PREEMPTIRQ_TRACEPOINTS
 
 config TRACING
 	bool
-	select DEBUG_FS
 	select RING_BUFFER
 	select STACKTRACE if STACKTRACE_SUPPORT
 	select TRACEPOINTS
-- 
2.24.0

