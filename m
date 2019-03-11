Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B28C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AC01222EB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfCKNbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:31:02 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:36611 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfCKNTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:30 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N1wdj-1gx3SD04Bl-012IhG for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:28 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 004/114] drivers: watchdog: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:16 +0100
Message-Id: <1552310346-7629-5-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:8IqKrxPTE6GXKU6/jjHLNzBYbG6b3/sZ5IzWlwNIAMGE6e8pSsI
 IYAjyFsOQgeEpn9FVZcRS5r1H7Ex0BCNcQY18xe9a2//B9RK9ZVL8x7Tg1RfJwAasXHeDsu
 yD0laV4Fn/Ai6G8GYb7ysl53+GbxfJn9Ck0Bos+8uZxk6sy+reCBI9IY/NFZgF/uXg0Ytgk
 UDwsw8h8dE1SC05OIdSCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WlbFdfsdY+4=:ryyBx8ONZ4Y32mc1Flw70m
 V8AOxZz55huPmcvYLw+/j+wXeNi0PCwlGmmcMB/0X9InUtIClZ2jBapQ9H1Nuxp1qDkfwHCmu
 jrWuRnls9KFqFQwGWFKWnfh9vTQdgSOTcKWhNChOIs4ij9QnoDZ0uuDKeEXinHkWwD7zBB9JM
 BGylYP9u10AuZKTcYuz7G/q97c58vNdX6WOWbi8RK0qbNIWyaJI/EtPCScaxp6MYZDWbdk7IB
 NYS73PBufxpYOigUstY5IC/BlDgm4hZ21rLPQGTgc7ea8xGqEUzjGhOSSAY/N3IFQC48Jc+gf
 cc5O2F64sYSQ/T7MazBqjo91Pinpp2Rf/RVSu99GZtzd3nU7Fhiek4gBUAWtlzGiR0093ahul
 HIuq8X5ZYOGH4Ku8CQWL+nJOrTXIKYfkM0IQcCptL7ldy7YbzpVDwhX5UiQZVbt6VpYtUUvMc
 EN3B3fRs2sBbRQMtSaUWM7F3gTQI+Q2ACg5krjKbRQPMsKhvoP4LWkKUaCn6X/viAOQBurG3R
 QGwXQ7JHuDxR5q51AVxM2n4cEiwxaxUVZUKSo0MjbQE4Ko1DTjjhb8wH57Xhdx7iKoFUveJLX
 c3wWj1lxGoWvVxXrq4Xfch9Umlal5L6a4TLsySskGdsos+aUxfMW+cEO/LWxStVjhQdrDntwu
 Vq+joDbmSE/NrvU0dx1EUAgIcPCoSksFtX4Wjdy8Eg3fOD7F4lGJVR0UwpVVVnLemxicXtV7f
 RshaRGnEOzI5OeVGl2pAg9Iq92UtaFnYpHQtYA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/watchdog/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 65c3c42..89b331c 100644
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
@@ -1644,10 +1644,10 @@ config BCM7038_WDT
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

