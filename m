Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB74C5B578
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 04:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67A5820863
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 04:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfGFEmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 00:42:18 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8715 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbfGFEmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 00:42:17 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 05C035D857FD44271D88;
        Sat,  6 Jul 2019 12:42:13 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Sat, 6 Jul 2019 12:42:04 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <marc.zyngier@arm.com>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] irq/irqdomain: Fix typo in the comment on top of __irq_domain_add()
Date:   Sat, 6 Jul 2019 04:41:12 +0000
Message-ID: <1562388072-23492-1-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in the comment on top of __irq_domain_add().

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index a453e22..db7b713 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -123,7 +123,7 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
  * @ops: domain callbacks
  * @host_data: Controller private data pointer
  *
- * Allocates and initialize and irq_domain structure.
+ * Allocates and initializes an irq_domain structure.
  * Returns pointer to IRQ domain, or NULL on failure.
  */
 struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
-- 
1.8.3.1


