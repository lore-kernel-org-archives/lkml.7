Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0114DC282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 11:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C316F218D3
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 11:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="rt8dKCis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfDNLrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 07:47:17 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:43866 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfDNLrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 07:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1555242434; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5mxHJ/S+iHpHWhTT+jBAQVanyxMcifV6es6FY54yV1I=;
        b=rt8dKCisDWR1Pouwv0b6835I8AJQcCTLHX3Ws7hHv3/eEWGQgAlLX53erFEV0aapPwxxJy
        aZEQC6TWDLLyHq/LiWCt2l8Vees/dtlI6kknV921m6UGzAMU2RyKtoz1hAr1RnU461Y541
        7I42Eh4sdVZ/KOyesf4YZEimkSqbxhg=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        od@zcrc.me, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 RESEND 2/4] memory: Kconfig: Drop dependency on MACH_JZ4780 for jz4780
Date:   Sun, 14 Apr 2019 13:47:00 +0200
Message-Id: <20190414114702.8236-2-paul@crapouillou.net>
In-Reply-To: <20190414114702.8236-1-paul@crapouillou.net>
References: <20190414114702.8236-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depending on MACH_JZ4780 prevent us from creating a generic kernel that
works on more than one MIPS board. Instead, we just depend on MIPS being
set.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
---

v2: No change

v3: No change

 drivers/memory/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 2d91b00e3591..3d411575fcb6 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -122,7 +122,7 @@ config FSL_IFC
 config JZ4780_NEMC
 	bool "Ingenic JZ4780 SoC NEMC driver"
 	default y
-	depends on MACH_JZ4780 || COMPILE_TEST
+	depends on MIPS || COMPILE_TEST
 	depends on HAS_IOMEM && OF
 	help
 	  This driver is for the NAND/External Memory Controller (NEMC) in
-- 
2.11.0

