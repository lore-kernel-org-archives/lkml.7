Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13314C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D628920821
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389641AbfDRP6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:58:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36312 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731317AbfDRP6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:58:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFE4215AB;
        Thu, 18 Apr 2019 08:58:23 -0700 (PDT)
Received: from e108454-lin.cambridge.arm.com (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF6BA3F5AF;
        Thu, 18 Apr 2019 08:58:22 -0700 (PDT)
From:   Julien Grall <julien.grall@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        Julien Grall <julien.grall@arm.com>
Subject: [PATCH] irqchip/gic-v3-its: Fix typo in a comment in its_msi_prepare()
Date:   Thu, 18 Apr 2019 16:58:14 +0100
Message-Id: <20190418155814.14844-1-julien.grall@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word 'entirely' has been misspelt in a comment in its_msi_prepare().

Signed-off-by: Julien Grall <julien.grall@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 7577755bdcf4..8d5936c899a6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2487,7 +2487,7 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
 	int err = 0;
 
 	/*
-	 * We ignore "dev" entierely, and rely on the dev_id that has
+	 * We ignore "dev" entirely, and rely on the dev_id that has
 	 * been passed via the scratchpad. This limits this domain's
 	 * usefulness to upper layers that definitely know that they
 	 * are built on top of the ITS.
-- 
2.11.0

