Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C397CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12FE2089C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbfKDXuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 18:50:23 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39249 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbfKDXuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:50:22 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iRm6y-0001L4-KI; Tue, 05 Nov 2019 00:50:16 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 345E21C0105;
        Tue,  5 Nov 2019 00:50:16 +0100 (CET)
Date:   Mon, 04 Nov 2019 23:50:15 -0000
From:   "tip-bot2 for Yi Wang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irq/irqdomain: Update __irq_domain_alloc_fwnode()
 function documentation
Cc:     Yi Wang <wang.yi59@zte.com.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1571476047-29463-1-git-send-email-wang.yi59@zte.com.cn>
References: <1571476047-29463-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Message-ID: <157291141580.29376.15475293191826242744.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     0ed9ca25894ef673d0259e4bd312d5fa1b9a6591
Gitweb:        https://git.kernel.org/tip/0ed9ca25894ef673d0259e4bd312d5fa1b9a6591
Author:        Yi Wang <wang.yi59@zte.com.cn>
AuthorDate:    Sat, 19 Oct 2019 17:07:27 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 05 Nov 2019 00:48:26 +01:00

irq/irqdomain: Update __irq_domain_alloc_fwnode() function documentation

A recent commit changed a parameter of __irq_domain_alloc_fwnode(), but
did not update the documentation comment. Fix it up.

Fixes: b977fcf477c1 ("irqdomain/debugfs: Use PAs to generate fwnode names")
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1571476047-29463-1-git-send-email-wang.yi59@zte.com.cn

---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 132672b..dd822fd 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -51,7 +51,7 @@ EXPORT_SYMBOL_GPL(irqchip_fwnode_ops);
  * @type:	Type of irqchip_fwnode. See linux/irqdomain.h
  * @name:	Optional user provided domain name
  * @id:		Optional user provided id if name != NULL
- * @data:	Optional user-provided data
+ * @pa:		Optional user-provided physical address
  *
  * Allocate a struct irqchip_fwid, and return a poiner to the embedded
  * fwnode_handle (or NULL on failure).
