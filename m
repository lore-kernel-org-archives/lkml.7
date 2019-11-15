Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A9CC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39342073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 09:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfKOJyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 04:54:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42980 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfKOJyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:54:44 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iVYJL-0004n1-EF; Fri, 15 Nov 2019 10:54:39 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 19EEC1C08AC;
        Fri, 15 Nov 2019 10:54:39 +0100 (CET)
Date:   Fri, 15 Nov 2019 09:54:38 -0000
From:   "tip-bot2 for luanshi" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Fix function documentation of __irq_alloc_descs()
Cc:     Liguang Zhang <zhangliguang@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1573656093-8643-1-git-send-email-zhangliguang@linux.alibaba.com>
References: <1573656093-8643-1-git-send-email-zhangliguang@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <157381167867.29467.8597837838965780215.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     20a15ee040f23bd553d4e6bbb1f8724ccd282abc
Gitweb:        https://git.kernel.org/tip/20a15ee040f23bd553d4e6bbb1f8724ccd282abc
Author:        luanshi <zhangliguang@linux.alibaba.com>
AuthorDate:    Wed, 13 Nov 2019 22:41:33 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 15 Nov 2019 10:48:38 +01:00

genirq: Fix function documentation of __irq_alloc_descs()

The function got renamed at some point, but the kernel-doc was not updated.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1573656093-8643-1-git-send-email-zhangliguang@linux.alibaba.com

---
 kernel/irq/irqdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 9be995f..5b8fdd6 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -750,7 +750,7 @@ void irq_free_descs(unsigned int from, unsigned int cnt)
 EXPORT_SYMBOL_GPL(irq_free_descs);
 
 /**
- * irq_alloc_descs - allocate and initialize a range of irq descriptors
+ * __irq_alloc_descs - allocate and initialize a range of irq descriptors
  * @irq:	Allocate for specific irq number if irq >= 0
  * @from:	Start the search from this irq number
  * @cnt:	Number of consecutive irqs to allocate.
