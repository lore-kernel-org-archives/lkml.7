Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15054C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E30EB207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 08:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbfIMIIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 04:08:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48055 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbfIMIIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 04:08:51 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1i8gdN-0005HD-Uf; Fri, 13 Sep 2019 08:08:50 +0000
From:   Colin King <colin.king@canonical.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] genirq/debugfs: fix spelling mistake "effectiv" -> "effective"
Date:   Fri, 13 Sep 2019 09:08:49 +0100
Message-Id: <20190913080849.29050-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in the debugfs output, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 kernel/irq/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index c1eccd4f6520..55b1b7ce667e 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -36,7 +36,7 @@ static void irq_debug_show_masks(struct seq_file *m, struct irq_desc *desc)
 	seq_printf(m, "affinity: %*pbl\n", cpumask_pr_args(msk));
 #ifdef CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK
 	msk = irq_data_get_effective_affinity_mask(data);
-	seq_printf(m, "effectiv: %*pbl\n", cpumask_pr_args(msk));
+	seq_printf(m, "effective: %*pbl\n", cpumask_pr_args(msk));
 #endif
 #ifdef CONFIG_GENERIC_PENDING_IRQ
 	msk = desc->pending_mask;
-- 
2.20.1

