Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE50C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1722251F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfKTNV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:21:56 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56837 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbfKTNV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:29 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPv8-0007H3-Pr; Wed, 20 Nov 2019 14:21:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1EDC61C1A23;
        Wed, 20 Nov 2019 14:21:07 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:07 -0000
From:   "tip-bot2 for Daode Huang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Remove redundant semicolon after while
Cc:     Daode Huang <huangdaode@hisilicon.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1571300729-38822-1-git-send-email-huangdaode@hisilicon.com>
References: <1571300729-38822-1-git-send-email-huangdaode@hisilicon.com>
MIME-Version: 1.0
Message-ID: <157425606706.12247.9462338694860117345.tip-bot2@tip-bot2>
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

Commit-ID:     2c542426128a4e3d247939f868d19279ad48cb1f
Gitweb:        https://git.kernel.org/tip/2c542426128a4e3d247939f868d19279ad48cb1f
Author:        Daode Huang <huangdaode@hisilicon.com>
AuthorDate:    Thu, 17 Oct 2019 16:25:29 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:47:44 

irqchip: Remove redundant semicolon after while

check drivers/irqchip with "make coccicheck M=drivers/irqchip/",
it will report unneeded semicolon like below, just remove them.

drivers/irqchip/irq-zevio.c:54:2-3: Unneeded semicolon
drivers/irqchip/irq-gic-v3.c:177:2-3: Unneeded semicolon
drivers/irqchip/irq-gic-v3.c:234:2-3: Unneeded semicolon

Signed-off-by: Daode Huang <huangdaode@hisilicon.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1571300729-38822-1-git-send-email-huangdaode@hisilicon.com
---
 drivers/irqchip/irq-gic-v3.c | 4 ++--
 drivers/irqchip/irq-zevio.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 1edc993..9e35155 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -174,7 +174,7 @@ static void gic_do_wait_for_rwp(void __iomem *base)
 		}
 		cpu_relax();
 		udelay(1);
-	};
+	}
 }
 
 /* Wait for completion of a distributor change */
@@ -231,7 +231,7 @@ static void gic_enable_redist(bool enable)
 			break;
 		cpu_relax();
 		udelay(1);
-	};
+	}
 	if (!count)
 		pr_err_ratelimited("redistributor failed to %s...\n",
 				   enable ? "wakeup" : "sleep");
diff --git a/drivers/irqchip/irq-zevio.c b/drivers/irqchip/irq-zevio.c
index 5a7efeb..84163f1 100644
--- a/drivers/irqchip/irq-zevio.c
+++ b/drivers/irqchip/irq-zevio.c
@@ -51,7 +51,7 @@ static void __exception_irq_entry zevio_handle_irq(struct pt_regs *regs)
 	while (readl(zevio_irq_io + IO_STATUS)) {
 		irqnr = readl(zevio_irq_io + IO_CURRENT);
 		handle_domain_irq(zevio_irq_domain, irqnr, regs);
-	};
+	}
 }
 
 static void __init zevio_init_irq_base(void __iomem *base)
