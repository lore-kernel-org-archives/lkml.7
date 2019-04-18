Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF88C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B21121479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389554AbfDRPyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:54:08 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36154 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388097AbfDRPyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:54:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16A3C15AB;
        Thu, 18 Apr 2019 08:54:08 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2935F3F5AF;
        Thu, 18 Apr 2019 08:54:07 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     marc.zyngier@arm.com, tglx@linutronix.de,
        Julien Grall <julien.grall@arm.com>
Subject: [PATCH] irq/irqdomain: Fix typo in the comment on top of __irq_domain_alloc_irqs()
Date:   Thu, 18 Apr 2019 16:54:01 +0100
Message-Id: <20190418155401.14185-1-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word 'number' has been misspelt in the comment on top of
_irq_domain_alloc_irqs().

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 9ed29e4a7dbf..a453e229f99c 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1297,7 +1297,7 @@ int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
 /**
  * __irq_domain_alloc_irqs - Allocate IRQs from domain
  * @domain:	domain to allocate from
- * @irq_base:	allocate specified IRQ nubmer if irq_base >= 0
+ * @irq_base:	allocate specified IRQ number if irq_base >= 0
  * @nr_irqs:	number of IRQs to allocate
  * @node:	NUMA node id for memory allocation
  * @arg:	domain specific argument
-- 
2.11.0

