Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05157C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7ED2204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 07:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="1vPZvMBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfHSHqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 03:46:16 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:58499 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfHSHqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 03:46:16 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id x7J7jZ2B003037;
        Mon, 19 Aug 2019 16:45:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com x7J7jZ2B003037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566200736;
        bh=PTT95AzOj8pXHNHkWmOjjuSXo/Qr4YIEL7ZDUlRqoLI=;
        h=From:To:Cc:Subject:Date:From;
        b=1vPZvMBHbm4/61iUH7vWpiMO59L7MLxOvF2PZ9z6LKpSGoF17OcwcXuFJnlBbdryN
         ExQDu+RiNlj1w0y+95RChuX9E8UMeEEzPlBwLGqX1viz1FEg9F3bpcOmukREPCAV1B
         9HoDyGBGKd8HZW3LZySHOuRYvx8KsXQwbVQLwf7RNcQjDHONZWTfMWq7ggiWeahOV0
         bXhmKKd6rDHLyAik+9RQCYjMLBo3LBaNGO2ZLhZW4ITN+RKyzB4fxGtAIjErNBcYZ8
         ZfXiy6HYCTelyQ/9QbxEVlCvowXavSpR1OonMECljPPGuS3cHx3veKduicrsLQdNXO
         3walVUj1I/0ag==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] irqchip: add include guard to irq-partition-percpu.h
Date:   Mon, 19 Aug 2019 16:45:34 +0900
Message-Id: <20190819074534.13028-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/irqchip/irq-partition-percpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/irqchip/irq-partition-percpu.h b/include/linux/irqchip/irq-partition-percpu.h
index a783ddb58444..2f6ae7551748 100644
--- a/include/linux/irqchip/irq-partition-percpu.h
+++ b/include/linux/irqchip/irq-partition-percpu.h
@@ -4,6 +4,9 @@
  * Author: Marc Zyngier <marc.zyngier@arm.com>
  */
 
+#ifndef __LINUX_IRQCHIP_IRQ_PARTITION_PERCPU_H
+#define __LINUX_IRQCHIP_IRQ_PARTITION_PERCPU_H
+
 #include <linux/fwnode.h>
 #include <linux/cpumask.h>
 #include <linux/irqdomain.h>
@@ -46,3 +49,5 @@ struct irq_domain *partition_get_domain(struct partition_desc *dsc)
 	return NULL;
 }
 #endif
+
+#endif /* __LINUX_IRQCHIP_IRQ_PARTITION_PERCPU_H */
-- 
2.17.1

