Return-Path: <SRS0=X3/1=2E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0C3C43603
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B04214AF
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Dec 2019 22:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="EDeuY7by"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbfLNWMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 17:12:01 -0500
Received: from outils.crapouillou.net ([89.234.176.41]:55008 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfLNWMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 17:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1576361494; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wO86ve54NEKdhdaSZv4eNbfzAoNfLippFMfAu/0tZxw=;
        b=EDeuY7byW2/Fcijm901XMG1DJ11Ea+QXHZPuZjhXT0tLJB83Rg8mpvBjLDG1JXgi8t0CXt
        N1OliQhJVUoyiqQ4yUZECLOFaG+ZQMbsbEtfDkd/TcggaZIQ2MG1VQa3hM5ilZkW5Gk4Dc
        jUZcvZHyQI8wbICe/5LjWPTiZ69ayi0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     od@zcrc.me, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 5/6] usb: musb: jz4740: Comments fix
Date:   Sat, 14 Dec 2019 23:11:25 +0100
Message-Id: <20191214221126.93116-5-paul@crapouillou.net>
In-Reply-To: <20191214221126.93116-1-paul@crapouillou.net>
References: <20191214221126.93116-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a /* sentinel */ comment to the sentinel entry of the devicetree ID
table, and fix a multi-line comment not having its opening token on a
separate line.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/usb/musb/jz4740.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/musb/jz4740.c b/drivers/usb/musb/jz4740.c
index e2baa1b6bad6..a8cd2ba2ed06 100644
--- a/drivers/usb/musb/jz4740.c
+++ b/drivers/usb/musb/jz4740.c
@@ -88,7 +88,8 @@ static int jz4740_musb_init(struct musb *musb)
 		return err;
 	}
 
-	/* Silicon does not implement ConfigData register.
+	/*
+	 * Silicon does not implement ConfigData register.
 	 * Set dyn_fifo to avoid reading EP config from hardware.
 	 */
 	musb->dyn_fifo = true;
@@ -197,7 +198,7 @@ static int jz4740_remove(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id jz4740_musb_of_match[] = {
 	{ .compatible = "ingenic,jz4740-musb" },
-	{},
+	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, jz4740_musb_of_match);
 #endif
-- 
2.24.0

