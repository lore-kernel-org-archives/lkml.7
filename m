Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5396BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 06:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B1F20643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 06:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfCRGvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 02:51:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53928 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfCRGvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 02:51:31 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5691030821B4;
        Mon, 18 Mar 2019 06:51:31 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-116.nay.redhat.com [10.66.14.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 044AE5C882;
        Mon, 18 Mar 2019 06:51:24 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dou Liyang <douliyangs@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH] genirq: Fix typo in comment of IRQD_MOVE_PCNTXT
Date:   Mon, 18 Mar 2019 14:51:23 +0800
Message-Id: <20190318065123.11862-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 18 Mar 2019 06:51:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC: Marc Zyngier <marc.zyngier@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Dou Liyang <douliyangs@gmail.com>
CC: Julien Thierry <julien.thierry@arm.com>
CC: Peter Xu <peterx@redhat.com>
CC: linux-kernel@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/irq.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 5e91f6bcaacd..965613abe93b 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -195,7 +195,7 @@ struct irq_data {
  * IRQD_LEVEL			- Interrupt is level triggered
  * IRQD_WAKEUP_STATE		- Interrupt is configured for wakeup
  *				  from suspend
- * IRDQ_MOVE_PCNTXT		- Interrupt can be moved in process
+ * IRQD_MOVE_PCNTXT		- Interrupt can be moved in process
  *				  context
  * IRQD_IRQ_DISABLED		- Disabled state of the interrupt
  * IRQD_IRQ_MASKED		- Masked state of the interrupt
-- 
2.17.1

