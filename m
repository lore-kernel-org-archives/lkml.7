Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471F0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FF820675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfCFPQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:16:10 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:46651 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbfCFPQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:16:10 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MAwPZ-1gqFjm1nUf-00BJU2; Wed, 06 Mar 2019 16:15:39 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org
Subject: [PATCH] drivers: watchdog: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 16:15:36 +0100
Message-Id: <1551885336-22650-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:icLKGGgsB3oqZHjaMkIQitmdLt+pyyeDFSTiXJpIzywHwWO8fzM
 bqrIQW6RKnzpseApq2Jn24uKZw/NerZVA8NSzzLV8uL0ZQi6zZFDfxHA4xha8/7SQsK6qN9
 WPxZt0PEInePFPn8AEZgScnZkH254snkuVgHouhIXpNv5DfdeF4hHEazzopBwAVRNUd/p6r
 ou0j1BvkffIiPbg5qf54Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hSGc66A29WE=:R00o4nDw8HBPxCvKhZKmOr
 ejG9ScIuijjc8Ewz7rTjlVbvvxj2Ot1OT5xmxfgEMZeEC5xfQlmzUX5MgmcvFM9GFu+JzCGir
 O15xM3nzKOzrcjnuNIqRUFJcRelOIvLvpI90Bija3B4fNhefrYlux4KR61NID+y8s1aRgG/Bg
 UypMfnFCmzkt/AhwWG+9DIx2yJoCO9EgAZB30g1cgz+zkwG5NNGfldMF26vXK5fZsT72kUwU1
 3VvjZaAMb7M94zaFJsM6Q/7HgLeV/NJpyHg/5E2f1z5rvs+TOXRdqEE1tC9B0gS5UjxH9f838
 EjIgqsW6Sm4l+h30c71Owgxe/RruT1z7Y/Z2X93hcCRKWyJI80nA9OSvLD/KT56BaZry6WuUU
 V3AK8WkjO5LhU5fR305gW8FnP1dcd2BYTJ4zgOx+k4SneKNB4xzPkknrA1dlW5CYWiZAoHxEr
 usLhjXOaeiTOGpYWkZp0yh6MQhtiE3TAt4wwS6LMDiW/cRk42T41CxnRlFZrgEaAmXEIrAsPm
 SIKx6N6IjZEJZcIB2DpQnf7Cm36foD+mBpKt0yXiX0c/v3nqrFLfzul4GZzVje+0nk+2aNb0G
 INsa0VA9bays/bj6xB5g9Wqv4dZ5ZffgrtSocqX8OG04+lFZRql47F9c3L4cbOWppetd4/jQm
 qXAW2s4Mlsf6tAPelR5QgvZ1tqjclkgkKy95sEGbegtW8K/cWrfMXunAwp6Xuxc5XrikiTf0t
 vuwe4wTUsi+Omx0m6WLlV9gy6Qz7Ru+RYBzXMw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/watchdog/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 57f017d..38509d5 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -279,10 +279,10 @@ config ARMADA_37XX_WATCHDOG
 	select MFD_SYSCON
 	select WATCHDOG_CORE
 	help
-	   Say Y here to include support for the watchdog timer found on
-	   Marvell Armada 37xx SoCs.
-	   To compile this driver as a module, choose M here: the
-	   module will be called armada_37xx_wdt.
+	  Say Y here to include support for the watchdog timer found on
+	  Marvell Armada 37xx SoCs.
+	  To compile this driver as a module, choose M here: the
+	  module will be called armada_37xx_wdt.
 
 config ASM9260_WATCHDOG
 	tristate "Alphascale ASM9260 watchdog"
@@ -606,10 +606,10 @@ config MAX77620_WATCHDOG
 	tristate "Maxim Max77620 Watchdog Timer"
 	depends on MFD_MAX77620 || COMPILE_TEST
 	help
-	 This is the driver for the Max77620 watchdog timer.
-	 Say 'Y' here to enable the watchdog timer support for
-	 MAX77620 chips. To compile this driver as a module,
-	 choose M here: the module will be called max77620_wdt.
+	  This is the driver for the Max77620 watchdog timer.
+	  Say 'Y' here to enable the watchdog timer support for
+	  MAX77620 chips. To compile this driver as a module,
+	  choose M here: the module will be called max77620_wdt.
 
 config IMX2_WDT
 	tristate "IMX2+ Watchdog"
@@ -1632,10 +1632,10 @@ config BCM7038_WDT
 	depends on HAS_IOMEM
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	help
-	 Watchdog driver for the built-in hardware in Broadcom 7038 and
-	 later SoCs used in set-top boxes.  BCM7038 was made public
-	 during the 2004 CES, and since then, many Broadcom chips use this
-	 watchdog block, including some cable modem chips.
+	  Watchdog driver for the built-in hardware in Broadcom 7038 and
+	  later SoCs used in set-top boxes.  BCM7038 was made public
+	  during the 2004 CES, and since then, many Broadcom chips use this
+	  watchdog block, including some cable modem chips.
 
 config IMGPDC_WDT
 	tristate "Imagination Technologies PDC Watchdog Timer"
-- 
1.9.1

