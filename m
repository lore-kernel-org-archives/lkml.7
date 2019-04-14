Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC915C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3DA20870
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 20:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="jNiBwaiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfDNUIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 16:08:37 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:35660 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfDNUIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 16:08:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1555272512; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uZuvgEoW5jSMT5jg+gT9IvbVKxQRj342eWWyd/RLZBU=;
        b=jNiBwaivKqA9J+nbf03yEcsfF1/HCbMpoF36QR7UpBRn33CUTcf/repCuvWD4PiOY/+nuI
        BA7HBdf1mmeKyfa6S+PkSngaIY27+F98yhT0nCBTpqYvuS+pSxpdRBdOv+68pJ4ag1pU+l
        Bq0gnVsR5M8Q72hRsFgnoCr3WPsfMfY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 2/3] dt-bindings: Add header for the ingenic-drm driver bindings
Date:   Sun, 14 Apr 2019 22:08:23 +0200
Message-Id: <20190414200824.28348-2-paul@crapouillou.net>
In-Reply-To: <20190414200824.28348-1-paul@crapouillou.net>
References: <20190414200824.28348-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macros that can be used with the ingenic,lcd-mode property in the
devicetree node that corresponds to the ingenic-drm driver.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---

Notes:
    v2: No change
    
    v3: s/_DRM//

 include/dt-bindings/display/ingenic,drm.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 include/dt-bindings/display/ingenic,drm.h

diff --git a/include/dt-bindings/display/ingenic,drm.h b/include/dt-bindings/display/ingenic,drm.h
new file mode 100644
index 000000000000..c749b8c346fc
--- /dev/null
+++ b/include/dt-bindings/display/ingenic,drm.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  Ingenic JZ47xx KMS driver
+ *
+ *  Copyright (C) 2019, Paul Cercueil <paul@crapouillou.net>
+ */
+#ifndef __INCLUDE_DT_BINDINGS_DISPLAY_INGENIC_DRM_H__
+#define __INCLUDE_DT_BINDINGS_DISPLAY_INGENIC_DRM_H__
+
+#define JZ_LCD_GENERIC_16BIT			0
+#define JZ_LCD_GENERIC_18BIT			16
+
+#define JZ_LCD_SPECIAL_TFT_1			1
+#define JZ_LCD_SPECIAL_TFT_2			2
+#define JZ_LCD_SPECIAL_TFT_3			3
+
+#define JZ_LCD_NON_INTERLACED_TV_OUT		4
+#define JZ_LCD_INTERLACED_TV_OUT		6
+
+#define JZ_LCD_SINGLE_COLOR_STN			8
+#define JZ_LCD_SINGLE_MONOCHROME_STN		9
+#define JZ_LCD_DUAL_COLOR_STN			10
+#define JZ_LCD_DUAL_MONOCHROME_STN		11
+
+#define JZ_LCD_8BIT_SERIAL			12
+#define JZ_LCD_LCM				13
+
+#endif /* __INCLUDE_DT_BINDINGS_DISPLAY_INGENIC_DRM_H__ */
-- 
2.11.0

