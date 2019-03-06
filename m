Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B75C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A634A20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 21:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfCFVwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 16:52:33 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:34875 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCFVwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 16:52:32 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M60HD-1h96Rp1Oup-007XjX; Wed, 06 Mar 2019 22:52:06 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org
Subject: [PATCH v2] drivers: watchdog: Kconfig: pedantic formatting
Date:   Wed,  6 Mar 2019 22:52:05 +0100
Message-Id: <1551909125-20305-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <8a1297c7-f1f2-5742-0ef6-f83799510735@roeck-us.net>
References: <8a1297c7-f1f2-5742-0ef6-f83799510735@roeck-us.net>
X-Provags-ID: V03:K1:9xTm2JiTUZAyYNG07MdKHbzBZ8nkgkm+T8IZva6SuDN+gO5EuYN
 iPbejt6IUBeEHe0onA5PjVVjcD4XfzNKFaIzdTZh0vBg0FTdNfROtz7g+90RmcgcCznEIAH
 6Q73JRqQ5jV2AT73I6MU7L4AD0iWT+1YJD3rTfgnICVKjJrO8lUNPZNN8kajfCl3h9Hq0bE
 nh2QAtpz0hyRM88Y7y4AA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dQsoFl848gA=:yBC+0Lc6lpXDd8xrlAzhZw
 hReGBLa4u36gx7TFfPqyX6791i35JTmQtg/X6qCtns9GYzGj2sJhNny5mPN9qSdyTkZ4L/JxQ
 TlLMx3Y/FlrSsCgAWF/cD2oH/FXkriIbpKic6F3EYL1AqdU8OEf3RfPMyWYn0kzw3CKjXU23O
 NxIdQX0MAcBG1vUaPosxsVl60CjIONC3760x38a32mY9jjYGhG3RsxZXH90sYNj0XQ0i6Rd9g
 7srcyNCoxdloy9+xT48lVU38K+8jYSEW9XjSjKtMiXmwH+TMKMdZXGsCNtKiPBDBSHkUT7AiN
 rPJ/IL5UPypBpwtT85H31VUJ5Y0dvVbIhDbOQb4Bc5SbuVsqHdZcTcLfLUgwNInhNlYvgrltM
 GLdp5lyG9uOMdCwC5Ky4dgySBbPQpXoI0mBmhDNF7FNIfxyi+TdEFJW+mng6anYDN8eXu0OU5
 JC3PgzyKt4ibqSgph3v+M6HKtkQOrCtRzR0vDYFqcF7N0v45BHUJ3dFscf8QKIz+QHIIbbiOa
 XZPPaVmMNItYkE+lMSq3xxf8YO6F05g15Zkho4IwOljNljmeIiANOx7cg7K4tapoIx41RbVxm
 LOxz+ozripgYrLNkE1HAI+iWb8n6i5LDxbvHt8Qos0JqL+tu0R+z0hPDnYILeVqmyfHo2v8Lw
 Acjsx1mQ1sF6AggLw+fdw9/4fewxwiHFF0Yun7yjt8wsL1gzOA2lRg9XcLImxzI3BP3kugdLR
 3m9RXTR3Fu4eL24N+V68+pnQk39D0eL8ZrlQSw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so just
take damp cloth and clean it up.

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

