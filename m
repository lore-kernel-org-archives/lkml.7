Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3A2C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE833206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="oV+MAQ+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbfLNWMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 17:12:09 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:55048 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfLNWMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576361496; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TN0+FhuwFIyt1lIZC+35LLQzNXVjGCFlWEFqzkd6TBY=;
        b=oV+MAQ+xzwE33cGD/vwNaLe1wPsxdmO/yQCKvYPWYbjlmsm5CG2ETbEBVAvQH4limz+Ubr
        xu8OBL23edKhc/dkdTkuxBEA6BPQv78VzQVYyeAgBKrrOzgY5pCTtIJfPTaDIG3523aKtp
        CU+RBTak9ZeP2Ag9J7XYg9/hpwS57ok=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 6/6] usb: musb: jz4740: Whitespace and indentation fixes
Date:   Sat, 14 Dec 2019 23:11:26 +0100
Message-Id: <20191214221126.93116-6-paul@crapouillou.net>
In-Reply-To: <20191214221126.93116-1-paul@crapouillou.net>
References: <20191214221126.93116-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix lines with too much or not enough indentation, and lines which were
indented with spaces instead of tabs.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/musb/jz4740.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index a8cd2ba2ed06..f948eca654f3 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -23,9 +23,9 @@ struct jz4740_glue {
 
 static irqreturn_t jz4740_musb_interrupt(int irq, void *__hci)
 {
-	unsigned long   flags;
-	irqreturn_t     retval = IRQ_NONE, retval_dma = IRQ_NONE;
-	struct musb     *musb = __hci;
+	unsigned long	flags;
+	irqreturn_t	retval = IRQ_NONE, retval_dma = IRQ_NONE;
+	struct musb	*musb = __hci;
 
 	spin_lock_irqsave(&musb->lock, flags);
 
@@ -42,7 +42,7 @@ static irqreturn_t jz4740_musb_interrupt(int irq, void *__hci)
 	 * never see them set
 	 */
 	musb->int_usb &= MUSB_INTR_SUSPEND | MUSB_INTR_RESUME |
-	    MUSB_INTR_RESET | MUSB_INTR_SOF;
+			 MUSB_INTR_RESET | MUSB_INTR_SOF;
 
 	if (musb->int_usb || musb->int_tx || musb->int_rx)
 		retval = musb_interrupt(musb);
@@ -56,20 +56,20 @@ static irqreturn_t jz4740_musb_interrupt(int irq, void *__hci)
 }
 
 static struct musb_fifo_cfg jz4740_musb_fifo_cfg[] = {
-{ .hw_ep_num = 1, .style = FIFO_TX, .maxpacket = 512, },
-{ .hw_ep_num = 1, .style = FIFO_RX, .maxpacket = 512, },
-{ .hw_ep_num = 2, .style = FIFO_TX, .maxpacket = 64, },
+	{ .hw_ep_num = 1, .style = FIFO_TX, .maxpacket = 512, },
+	{ .hw_ep_num = 1, .style = FIFO_RX, .maxpacket = 512, },
+	{ .hw_ep_num = 2, .style = FIFO_TX, .maxpacket = 64, },
 };
 
 static const struct musb_hdrc_config jz4740_musb_config = {
 	/* Silicon does not implement USB OTG. */
-	.multipoint = 0,
+	.multipoint	= 0,
 	/* Max EPs scanned, driver will decide which EP can be used. */
-	.num_eps    = 4,
+	.num_eps	= 4,
 	/* RAMbits needed to configure EPs from table */
-	.ram_bits   = 9,
-	.fifo_cfg = jz4740_musb_fifo_cfg,
-	.fifo_cfg_size = ARRAY_SIZE(jz4740_musb_fifo_cfg),
+	.ram_bits	= 9,
+	.fifo_cfg	= jz4740_musb_fifo_cfg,
+	.fifo_cfg_size	= ARRAY_SIZE(jz4740_musb_fifo_cfg),
 };
 
 static int jz4740_musb_init(struct musb *musb)
@@ -122,7 +122,7 @@ static int jz4740_probe(struct platform_device *pdev)
 	const struct musb_hdrc_platform_data *pdata = &jz4740_musb_pdata;
 	struct platform_device		*musb;
 	struct jz4740_glue		*glue;
-	struct clk                      *clk;
+	struct clk			*clk;
 	int				ret;
 
 	glue = devm_kzalloc(dev, sizeof(*glue), GFP_KERNEL);
@@ -187,7 +187,7 @@ static int jz4740_probe(struct platform_device *pdev)
 
 static int jz4740_remove(struct platform_device *pdev)
 {
-	struct jz4740_glue	*glue = platform_get_drvdata(pdev);
+	struct jz4740_glue *glue = platform_get_drvdata(pdev);
 
 	platform_device_unregister(glue->pdev);
 	clk_disable_unprepare(glue->clk);
-- 
2.24.0

