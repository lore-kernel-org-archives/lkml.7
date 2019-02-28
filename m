Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DF4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 481AC218E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 17:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551374077;
	bh=xw7JY64L2KzcYyGds+5kuiOQ6f6h6RhZa4FqfjKvdlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BQAVSuJET3qzg4rZnRR3AVvmauMSyNLeQMRtMnQtM3fKPVauWmHDyCRqKRaoA/G2Z
	 yvzXrtHiYNagVbxxDlH2DlBP7IsGs+YD+K40pLY+lrJ0kbZX0mwUD7xTKN3ojrcczk
	 75UkBmn175LbxHw42Q/iYpnMcKi/5MTS7agd4ODA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388030AbfB1ROf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 12:14:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387984AbfB1ROa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 12:14:30 -0500
Received: from lerouge.home (lfbn-1-18527-45.w90-101.abo.wanadoo.fr [90.101.69.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28A0B218AE;
        Thu, 28 Feb 2019 17:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551374070;
        bh=xw7JY64L2KzcYyGds+5kuiOQ6f6h6RhZa4FqfjKvdlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KNjJmj1vImV2vv4JdlfRvisxAZ7529TM2qvLyiy4wtmcGE4sS0u7ilpf44UFq3wtZ
         lOudcc8tALLWFands9RkGbObzx9nB8R755HUMvI9isQII0zwagqlzfgvwfpPqqIpiS
         6lOvQ54oJhBkdMBc+1GpmU6KcaIAd7nXXwGxxW8o=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 28/37] softirq: Remove stale comment
Date:   Thu, 28 Feb 2019 18:12:33 +0100
Message-Id: <20190228171242.32144-29-frederic@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190228171242.32144-1-frederic@kernel.org>
References: <20190228171242.32144-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__local_bh_disable_ip() is neither for strict internal use nor does it
require the caller to disable hardirqs. Probaby a celebration for ancient
behaviour.

Reviewed-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Pavan Kondeti <pkondeti@codeaurora.org>
Cc: Paul E . McKenney <paulmck@linux.vnet.ibm.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/softirq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 6c703bbb718b..60d1706ad47e 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -104,10 +104,6 @@ static bool ksoftirqd_running(unsigned long pending)
  * softirq and whether we just have bh disabled.
  */
 
-/*
- * This one is for softirq.c-internal use,
- * where hardirqs are disabled legitimately:
- */
 #ifdef CONFIG_TRACE_IRQFLAGS
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
-- 
2.21.0

