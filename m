Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C42C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F46A206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XAsKkLwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbfKNNdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:33:05 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40686 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfKNNdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:33:04 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAEDX1D2103984;
        Thu, 14 Nov 2019 07:33:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573738381;
        bh=CiO3hXAyFsuZm3cE8SXZzPxL1D+KaY4p9kZlHGgSu6M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=XAsKkLwmCbmrSZz0qqZ0uybtWehg+lTyb1r46JXCpf9lgI5tVmRgRRzRHFz1slhoM
         yvRufn4r7cDpQv1CXaWfSVWmEUF03HAlXf3JFJyAa+uZb1pxvaYJjtV0UnjxVudAZX
         TtonYgoPxdE0w4rwls5NrHYq5it/vqrmgDqm0DYk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAEDX1Un064593
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Nov 2019 07:33:01 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 14
 Nov 2019 07:33:01 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 14 Nov 2019 07:33:01 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAEDX1uP081637;
        Thu, 14 Nov 2019 07:33:01 -0600
From:   Dan Murphy <dmurphy@ti.com>
To:     <jacek.anaszewski@gmail.com>, <pavel@ucw.cz>
CC:     <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v17 19/19] leds: lp55xx-common: Remove extern from lp55xx-common header
Date:   Thu, 14 Nov 2019 07:30:23 -0600
Message-ID: <20191114133023.32185-20-dmurphy@ti.com>
X-Mailer: git-send-email 2.22.0.214.g8dca754b1e
In-Reply-To: <20191114133023.32185-1-dmurphy@ti.com>
References: <20191114133023.32185-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

extern is implied and is not needed in the common header file.
Remove the extern keyword and re-align the code.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/leds/leds-lp55xx-common.h | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/leds/leds-lp55xx-common.h b/drivers/leds/leds-lp55xx-common.h
index 18476051d3d2..051f8b33c601 100644
--- a/drivers/leds/leds-lp55xx-common.h
+++ b/drivers/leds/leds-lp55xx-common.h
@@ -183,29 +183,27 @@ struct lp55xx_led {
 };
 
 /* register access */
-extern int lp55xx_write(struct lp55xx_chip *chip, u8 reg, u8 val);
-extern int lp55xx_read(struct lp55xx_chip *chip, u8 reg, u8 *val);
-extern int lp55xx_update_bits(struct lp55xx_chip *chip, u8 reg,
-			u8 mask, u8 val);
+int lp55xx_write(struct lp55xx_chip *chip, u8 reg, u8 val);
+int lp55xx_read(struct lp55xx_chip *chip, u8 reg, u8 *val);
+int lp55xx_update_bits(struct lp55xx_chip *chip, u8 reg, u8 mask, u8 val);
 
 /* external clock detection */
-extern bool lp55xx_is_extclk_used(struct lp55xx_chip *chip);
+bool lp55xx_is_extclk_used(struct lp55xx_chip *chip);
 
 /* common device init/deinit functions */
-extern int lp55xx_init_device(struct lp55xx_chip *chip);
-extern void lp55xx_deinit_device(struct lp55xx_chip *chip);
+int lp55xx_init_device(struct lp55xx_chip *chip);
+void lp55xx_deinit_device(struct lp55xx_chip *chip);
 
 /* common LED class device functions */
-extern int lp55xx_register_leds(struct lp55xx_led *led,
-				struct lp55xx_chip *chip);
+int lp55xx_register_leds(struct lp55xx_led *led, struct lp55xx_chip *chip);
 
 /* common device attributes functions */
-extern int lp55xx_register_sysfs(struct lp55xx_chip *chip);
-extern void lp55xx_unregister_sysfs(struct lp55xx_chip *chip);
+int lp55xx_register_sysfs(struct lp55xx_chip *chip);
+void lp55xx_unregister_sysfs(struct lp55xx_chip *chip);
 
 /* common device tree population function */
-extern struct lp55xx_platform_data
-*lp55xx_of_populate_pdata(struct device *dev, struct device_node *np,
-			  struct lp55xx_chip *chip);
+struct lp55xx_platform_data *lp55xx_of_populate_pdata(struct device *dev,
+						      struct device_node *np,
+						      struct lp55xx_chip *chip);
 
 #endif /* _LEDS_LP55XX_COMMON_H */
-- 
2.22.0.214.g8dca754b1e

