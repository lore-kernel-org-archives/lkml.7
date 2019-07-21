Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE54C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 07:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3662084C
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 07:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XAJuBIGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfGUHkV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 03:40:21 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:16776 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfGUHkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 03:40:21 -0400
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x6L7did6032459;
        Sun, 21 Jul 2019 16:39:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x6L7did6032459
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563694785;
        bh=W0RUjdCqSIfb8kJEGYHindDEe89Kcz2+NHbUKHueqzc=;
        h=From:To:Cc:Subject:Date:From;
        b=XAJuBIGZ21ReoDh6CZlT/2Sh/YRKG/vB22kdveU1dNeOC1kP38EjuChgisNKIVrOw
         nP0mTnaux9Vc7IwAb79qiFVDk6PSB9LrZokQqd9jw6smAresbU8xv06eVzbpSDLc4S
         fehvQyXWPn3fdcTWAshQ32TgF7FyBabdgfbtVSK4wsZeT0W712INelHMpqzzhyDMQW
         lWP+YKTKNarlwoj24ACDAgVTGUrpd/qvNJ3J+aOVkleLJL5UeRp+lTx1Bt1nka7nvg
         mveHMD/kMimOPZ/0BR+Z12zrY3GEf96L2rxL4P8SW3v6Tz+J2O0ZQz5umGzJRXAmHR
         +hneKraGoJl2g==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: add include guards to platform_lcd.h and ili9320.h
Date:   Sun, 21 Jul 2019 16:39:40 +0900
Message-Id: <20190721073940.11422-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add header include guards just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/video/ili9320.h      | 4 ++++
 include/video/platform_lcd.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/video/ili9320.h b/include/video/ili9320.h
index 62f424f0bc52..b76a0b8f16fc 100644
--- a/include/video/ili9320.h
+++ b/include/video/ili9320.h
@@ -9,6 +9,9 @@
  * http://armlinux.simtec.co.uk/
 */
 
+#ifndef _VIDEO_ILI9320_H
+#define _VIDEO_ILI9320_H
+
 #define ILI9320_REG(x)	(x)
 
 #define ILI9320_INDEX			ILI9320_REG(0x00)
@@ -196,3 +199,4 @@ struct ili9320_platdata {
 	unsigned short	interface6;
 };
 
+#endif /* _VIDEO_ILI9320_H */
diff --git a/include/video/platform_lcd.h b/include/video/platform_lcd.h
index 6a95184a28c1..c68f3f45b5c1 100644
--- a/include/video/platform_lcd.h
+++ b/include/video/platform_lcd.h
@@ -7,6 +7,9 @@
  * Generic platform-device LCD power control interface.
 */
 
+#ifndef _VIDEO_PLATFORM_LCD_H
+#define _VIDEO_PLATFORM_LCD_H
+
 struct plat_lcd_data;
 struct fb_info;
 
@@ -16,3 +19,4 @@ struct plat_lcd_data {
 	int	(*match_fb)(struct plat_lcd_data *, struct fb_info *);
 };
 
+#endif /* _VIDEO_PLATFORM_LCD_H */
-- 
2.17.1

