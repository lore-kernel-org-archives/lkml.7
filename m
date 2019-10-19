Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940CBCA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 09:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A863222BD
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 09:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfJSJFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 05:05:16 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:11707 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726940AbfJSJFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 05:05:16 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 158269B3D21CB7E12465;
        Sat, 19 Oct 2019 17:05:13 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x9J95015079658;
        Sat, 19 Oct 2019 17:05:00 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019101917051614-32002 ;
          Sat, 19 Oct 2019 17:05:16 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     maz@kernel.org
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, up2wing@gmail.com,
        wang.liang82@zte.com.cn
Subject: [PATCH] irq/irqdomain: __irq_domain_alloc_fwnode comment
Date:   Sat, 19 Oct 2019 17:07:27 +0800
Message-Id: <1571476047-29463-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-10-19 17:05:16,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-10-19 17:05:07,
        Serialize complete at 2019-10-19 17:05:07
X-MAIL: mse-fl2.zte.com.cn x9J95015079658
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b977fcf477c1 ("irqdomain/debugfs: Use PAs to generate fwnode names")
changed the parameter of __irq_domain_alloc_fwnode(), but didn't
change the comment meanwhile.

This patch can fix this.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 132672b..dd822fd 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -51,7 +51,7 @@ static inline void debugfs_remove_domain_dir(struct irq_domain *d) { }
  * @type:	Type of irqchip_fwnode. See linux/irqdomain.h
  * @name:	Optional user provided domain name
  * @id:		Optional user provided id if name != NULL
- * @data:	Optional user-provided data
+ * @pa:		Optional user-provided physical address
  *
  * Allocate a struct irqchip_fwid, and return a poiner to the embedded
  * fwnode_handle (or NULL on failure).
-- 
1.8.3.1

