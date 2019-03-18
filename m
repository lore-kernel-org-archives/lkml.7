Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2EDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72CDC20872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbfCRPtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:49:04 -0400
Received: from sauhun.de ([88.99.104.3]:36864 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbfCRPtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:49:01 -0400
Received: from localhost (p54B330C6.dip0.t-ipconnect.de [84.179.48.198])
        by pokefinder.org (Postfix) with ESMTPSA id 530284A134C;
        Mon, 18 Mar 2019 16:48:59 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 5/6] mfd: da9063: remove leftover platform_data definitions
Date:   Mon, 18 Mar 2019 16:47:57 +0100
Message-Id: <20190318154759.21978-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not used, not needed, remove them.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/mfd/da9063/pdata.h | 65 ----------------------------------------
 1 file changed, 65 deletions(-)
 delete mode 100644 include/linux/mfd/da9063/pdata.h

diff --git a/include/linux/mfd/da9063/pdata.h b/include/linux/mfd/da9063/pdata.h
deleted file mode 100644
index 21a2d107f0cf..000000000000
--- a/include/linux/mfd/da9063/pdata.h
+++ /dev/null
@@ -1,65 +0,0 @@
-/*
- * Platform configuration options for DA9063
- *
- * Copyright 2012 Dialog Semiconductor Ltd.
- *
- * Author: Michal Hajduk, Dialog Semiconductor
- * Author: Krystian Garbaciak, Dialog Semiconductor
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- */
-
-#ifndef __MFD_DA9063_PDATA_H__
-#define __MFD_DA9063_PDATA_H__
-
-/*
- * RGB LED configuration
- */
-/* LED IDs for flags in struct led_info. */
-enum {
-	DA9063_GPIO11_LED,
-	DA9063_GPIO14_LED,
-	DA9063_GPIO15_LED,
-
-	DA9063_LED_NUM
-};
-#define DA9063_LED_ID_MASK		0x3
-
-/* LED polarity for flags in struct led_info. */
-#define DA9063_LED_HIGH_LEVEL_ACTIVE	0x0
-#define DA9063_LED_LOW_LEVEL_ACTIVE	0x4
-
-
-/*
- * General PMIC configuration
- */
-/* HWMON ADC channels configuration */
-#define DA9063_FLG_FORCE_IN0_MANUAL_MODE	0x0010
-#define DA9063_FLG_FORCE_IN0_AUTO_MODE		0x0020
-#define DA9063_FLG_FORCE_IN1_MANUAL_MODE	0x0040
-#define DA9063_FLG_FORCE_IN1_AUTO_MODE		0x0080
-#define DA9063_FLG_FORCE_IN2_MANUAL_MODE	0x0100
-#define DA9063_FLG_FORCE_IN2_AUTO_MODE		0x0200
-#define DA9063_FLG_FORCE_IN3_MANUAL_MODE	0x0400
-#define DA9063_FLG_FORCE_IN3_AUTO_MODE		0x0800
-
-/* Disable register caching. */
-#define DA9063_FLG_NO_CACHE			0x0008
-
-struct da9063;
-
-/* DA9063 platform data */
-struct da9063_pdata {
-	int				(*init)(struct da9063 *da9063);
-	int				irq_base;
-	bool				key_power;
-	unsigned			flags;
-	struct da9063_regulators_pdata	*regulators_pdata;
-	struct led_platform_data	*leds_pdata;
-};
-
-#endif	/* __MFD_DA9063_PDATA_H__ */
-- 
2.11.0

