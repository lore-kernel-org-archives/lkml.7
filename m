Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 807A2C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA5922529
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257158;
	bh=Z+eZq7iwaPRpNAmDEUhF3PizbEv3Dh2gfpmI5l4V05M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=0E/SqCJ35cbi98gQNnabiuuBN++bLj2IZEYoth+NwjHu5jTOMBkxBN+UysN2L/fEM
	 SealyugANe2DC+OJBPuK6bh6/NphM1CjhmzkFvsOB+r2xbUb3acdkOcq2+R0hTA+AM
	 La9gKmCeZcwlqXFuROrfz9RFVZrpvNx0U/w7pVfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbfKTNjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:39:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:46834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728167AbfKTNjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:39:16 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BEB4224FA;
        Wed, 20 Nov 2019 13:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257155;
        bh=Z+eZq7iwaPRpNAmDEUhF3PizbEv3Dh2gfpmI5l4V05M=;
        h=From:To:Cc:Subject:Date:From;
        b=uBE6mFT2S2HqG0fxEeNser1ycs5Wah7tXw+553v0tnVu76p1E/2bfxulblhcJm445
         M2KCMFt1flU9UnhKlPQrdxQoKu4FI3MQG9sY0sd4ylQ5GSG2YhD41hinHq2qiYUNQs
         jwxrxF4zdDduA9a0oclRRcJewaFRIEPK5flDDcgU=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH] staging: fbtft: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:39:11 +0800
Message-Id: <20191120133911.13539-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/staging/fbtft/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/fbtft/Kconfig b/drivers/staging/fbtft/Kconfig
index d994aea84b21..19d9d88e9150 100644
--- a/drivers/staging/fbtft/Kconfig
+++ b/drivers/staging/fbtft/Kconfig
@@ -95,8 +95,8 @@ config FB_TFT_PCD8544
 	  Generic Framebuffer support for PCD8544
 
 config FB_TFT_RA8875
-        tristate "FB driver for the RA8875 LCD Controller"
-        depends on FB_TFT
+	tristate "FB driver for the RA8875 LCD Controller"
+	depends on FB_TFT
 	help
 	  Generic Framebuffer support for RA8875
 
@@ -132,10 +132,10 @@ config FB_TFT_SSD1289
 	  Framebuffer support for SSD1289
 
 config FB_TFT_SSD1305
-        tristate "FB driver for the SSD1305 OLED Controller"
-        depends on FB_TFT
-        help
-          Framebuffer support for SSD1305
+	tristate "FB driver for the SSD1305 OLED Controller"
+	depends on FB_TFT
+	help
+	  Framebuffer support for SSD1305
 
 config FB_TFT_SSD1306
 	tristate "FB driver for the SSD1306 OLED Controller"
-- 
2.17.1

