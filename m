Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264F0C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DE1222D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 14:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfKMOls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 09:41:48 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:65221 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726982AbfKMOls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 09:41:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Ti-au6r_1573656095;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0Ti-au6r_1573656095)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Nov 2019 22:41:44 +0800
From:   luanshi <zhangliguang@linux.alibaba.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        luanshi <zhangliguang@linux.alibaba.com>
Subject: [PATCH] irq: fix kernel-doc notation
Date:   Wed, 13 Nov 2019 22:41:33 +0800
Message-Id: <1573656093-8643-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc notation in kernel/irq/irqdesc.c.

Signed-off-by: Liguang Zhang <zhangliguang@linux.alibaba.com>
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
-- 
1.8.3.1

