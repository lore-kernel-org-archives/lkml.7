Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6825C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18E120856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfDBVyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:54:51 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:59931 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDBVyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:54:51 -0400
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id ECFFC1BF204;
        Tue,  2 Apr 2019 21:54:48 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: remove unnecessary Kconfig dependencies
Date:   Tue,  2 Apr 2019 23:54:47 +0200
Message-Id: <20190402215447.5849-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused "depends on I2C" as the config options are already
guarded by if I2C.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 23b4102ee824..7b8e156dbf38 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -448,7 +448,6 @@ config RTC_DRV_PCF85063
 
 config RTC_DRV_PCF85363
 	tristate "NXP PCF85363"
-	depends on I2C
 	select REGMAP_I2C
 	help
 	  If you say yes here you get support for the PCF85363 RTC chip.
@@ -603,7 +602,6 @@ config RTC_DRV_FM3130
 
 config RTC_DRV_RX8010
 	tristate "Epson RX8010SJ"
-	depends on I2C
 	help
 	  If you say yes here you get support for the Epson RX8010SJ RTC
 	  chip.
-- 
2.20.1

