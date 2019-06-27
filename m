Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BE9C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0392085A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfF0MNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:13:18 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:52250 "EHLO
        faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726431AbfF0MNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:13:18 -0400
Received: from faui01a.informatik.uni-erlangen.de (faui01a.informatik.uni-erlangen.de [131.188.60.127])
        by faui03.informatik.uni-erlangen.de (Postfix) with ESMTP id 1D51F241569;
        Thu, 27 Jun 2019 14:12:51 +0200 (CEST)
Received: by faui01a.informatik.uni-erlangen.de (Postfix, from userid 30063)
        id 080D0F40079; Thu, 27 Jun 2019 14:12:50 +0200 (CEST)
From:   Lukas Schneider <lukas.s.schneider@fau.de>
To:     leobras.c@gmail.com, digholebhagyashri@gmail.com,
        bhanusreemahesh@gmail.com, daniel.vetter@ffwll.ch,
        der_wolf_@web.de, payal.s.kshirsagar.98@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Lukas Schneider <lukas.s.schneider@fau.de>,
        Jannik Moritz <jannik.moritz@fau.de>, linux-kernel@i4.cs.fau.de
Subject: [PATCH] fbtft: Cleanup line over 80 character warnings
Date:   Thu, 27 Jun 2019 14:12:40 +0200
Message-Id: <20190627121240.31584-1-lukas.s.schneider@fau.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup the line over 80 character warnings, reported by checkpatch

Signed-off-by: Lukas Schneider <lukas.s.schneider@fau.de>
Signed-off-by: Jannik Moritz <jannik.moritz@fau.de>
Cc: <linux-kernel@i4.cs.fau.de>
---
 drivers/staging/fbtft/fbtft-sysfs.c |  3 ++-
 drivers/staging/fbtft/fbtft.h       | 26 ++++++++++++++++++++++----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-sysfs.c b/drivers/staging/fbtft/fbtft-sysfs.c
index 2a5c630dab87..78d2b81ea2e7 100644
--- a/drivers/staging/fbtft/fbtft-sysfs.c
+++ b/drivers/staging/fbtft/fbtft-sysfs.c
@@ -68,7 +68,8 @@ int fbtft_gamma_parse_str(struct fbtft_par *par, u32 *curves,
 			ret = get_next_ulong(&curve_p, &val, " ", 16);
 			if (ret)
 				goto out;
-			curves[curve_counter * par->gamma.num_values + value_counter] = val;
+			curves[curve_counter * par->gamma.num_values
+				+ value_counter] = val;
 			value_counter++;
 		}
 		if (value_counter != par->gamma.num_values) {
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 9b6bdb62093d..cddbfd4ffa10 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -348,9 +348,25 @@ module_exit(fbtft_driver_module_exit);
 
 /* shorthand debug levels */
 #define DEBUG_LEVEL_1	DEBUG_REQUEST_GPIOS
-#define DEBUG_LEVEL_2	(DEBUG_LEVEL_1 | DEBUG_DRIVER_INIT_FUNCTIONS | DEBUG_TIME_FIRST_UPDATE)
-#define DEBUG_LEVEL_3	(DEBUG_LEVEL_2 | DEBUG_RESET | DEBUG_INIT_DISPLAY | DEBUG_BLANK | DEBUG_REQUEST_GPIOS | DEBUG_FREE_GPIOS | DEBUG_VERIFY_GPIOS | DEBUG_BACKLIGHT | DEBUG_SYSFS)
-#define DEBUG_LEVEL_4	(DEBUG_LEVEL_2 | DEBUG_FB_READ | DEBUG_FB_WRITE | DEBUG_FB_FILLRECT | DEBUG_FB_COPYAREA | DEBUG_FB_IMAGEBLIT | DEBUG_FB_BLANK)
+#define DEBUG_LEVEL_2	(DEBUG_LEVEL_1 |		\
+			 DEBUG_DRIVER_INIT_FUNCTIONS |	\
+			 DEBUG_TIME_FIRST_UPDATE)
+#define DEBUG_LEVEL_3	(DEBUG_LEVEL_2 |		\
+			 DEBUG_RESET |			\
+			 DEBUG_INIT_DISPLAY |		\
+			 DEBUG_BLANK |			\
+			 DEBUG_REQUEST_GPIOS |		\
+			 DEBUG_FREE_GPIOS |		\
+			 DEBUG_VERIFY_GPIOS |		\
+			 DEBUG_BACKLIGHT |		\
+			 DEBUG_SYSFS)
+#define DEBUG_LEVEL_4	(DEBUG_LEVEL_2 |		\
+			 DEBUG_FB_READ |		\
+			 DEBUG_FB_WRITE |		\
+			 DEBUG_FB_FILLRECT |		\
+			 DEBUG_FB_COPYAREA |		\
+			 DEBUG_FB_IMAGEBLIT |		\
+			 DEBUG_FB_BLANK)
 #define DEBUG_LEVEL_5	(DEBUG_LEVEL_3 | DEBUG_UPDATE_DISPLAY)
 #define DEBUG_LEVEL_6	(DEBUG_LEVEL_4 | DEBUG_LEVEL_5)
 #define DEBUG_LEVEL_7	0xFFFFFFFF
@@ -392,7 +408,9 @@ module_exit(fbtft_driver_module_exit);
 #define fbtft_init_dbg(dev, format, arg...)                  \
 do {                                                         \
 	if (unlikely((dev)->platform_data &&                 \
-	    (((struct fbtft_platform_data *)(dev)->platform_data)->display.debug & DEBUG_DRIVER_INIT_FUNCTIONS))) \
+		(((struct fbtft_platform_data *)	     \
+		(dev)->platform_data)->display.debug	     \
+		& DEBUG_DRIVER_INIT_FUNCTIONS)))	     \
 		dev_info(dev, format, ##arg);                \
 } while (0)
 
-- 
2.19.1

