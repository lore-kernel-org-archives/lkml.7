Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E98C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4E820873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 18:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731527AbfJNSi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 14:38:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40317 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731224AbfJNSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 14:38:57 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iK5F5-0005ag-Cj; Mon, 14 Oct 2019 20:38:51 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1C7831C0483;
        Mon, 14 Oct 2019 20:38:48 +0200 (CEST)
Date:   Mon, 14 Oct 2019 18:38:48 -0000
From:   "tip-bot2 for Sandeep Sheriker Mallikarjun" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/atmel-aic5: Add support for sam9x60 irqchip
Cc:     Sandeep Sheriker Mallikarjun 
        <sandeepsheriker.mallikarjun@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1568026835-6646-1-git-send-email-claudiu.beznea@microchip.com>
References: <1568026835-6646-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Message-ID: <157107832805.12254.7183157920442567022.tip-bot2@tip-bot2>
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

Commit-ID:     212fbf2c9e84ceb267cadd8342156b69b54b8135
Gitweb:        https://git.kernel.org/tip/212fbf2c9e84ceb267cadd8342156b69b54b8135
Author:        Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
AuthorDate:    Mon, 09 Sep 2019 14:00:35 +03:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 09 Sep 2019 18:11:51 +01:00

irqchip/atmel-aic5: Add support for sam9x60 irqchip

Add support for SAM9X60 irqchip.

Signed-off-by: Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1568026835-6646-1-git-send-email-claudiu.beznea@microchip.com

[claudiu.beznea@microchip.com: update aic5_irq_fixups[], update
 documentation]
---
 Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt |  7 +++++--
 drivers/irqchip/irq-atmel-aic5.c                                     | 10 ++++++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
index f4c5d34..7079d44 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
@@ -1,8 +1,11 @@
 * Advanced Interrupt Controller (AIC)
 
 Required properties:
-- compatible: Should be "atmel,<chip>-aic"
-  <chip> can be "at91rm9200", "sama5d2", "sama5d3" or "sama5d4"
+- compatible: Should be:
+    - "atmel,<chip>-aic" where  <chip> can be "at91rm9200", "sama5d2",
+      "sama5d3" or "sama5d4"
+    - "microchip,<chip>-aic" where <chip> can be "sam9x60"
+
 - interrupt-controller: Identifies the node as an interrupt controller.
 - #interrupt-cells: The number of cells to define the interrupts. It should be 3.
   The first cell is the IRQ number (aka "Peripheral IDentifier" on datasheet).
diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index 6acad2e..2933349 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -313,6 +313,7 @@ static void __init sama5d3_aic_irq_fixup(void)
 static const struct of_device_id aic5_irq_fixups[] __initconst = {
 	{ .compatible = "atmel,sama5d3", .data = sama5d3_aic_irq_fixup },
 	{ .compatible = "atmel,sama5d4", .data = sama5d3_aic_irq_fixup },
+	{ .compatible = "microchip,sam9x60", .data = sama5d3_aic_irq_fixup },
 	{ /* sentinel */ },
 };
 
@@ -390,3 +391,12 @@ static int __init sama5d4_aic5_of_init(struct device_node *node,
 	return aic5_of_init(node, parent, NR_SAMA5D4_IRQS);
 }
 IRQCHIP_DECLARE(sama5d4_aic5, "atmel,sama5d4-aic", sama5d4_aic5_of_init);
+
+#define NR_SAM9X60_IRQS		50
+
+static int __init sam9x60_aic5_of_init(struct device_node *node,
+				       struct device_node *parent)
+{
+	return aic5_of_init(node, parent, NR_SAM9X60_IRQS);
+}
+IRQCHIP_DECLARE(sam9x60_aic5, "microchip,sam9x60-aic", sam9x60_aic5_of_init);
