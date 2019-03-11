Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BC8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85DFF2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfCKNWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:22:05 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:44909 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfCKNTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:43 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MY60J-1hZR4q36IX-00YRWw for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:41 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 106/114] drivers: rtc: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:58 +0100
Message-Id: <1552310346-7629-107-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:RtSsGSe+iPDM5jrlu+q0mtrtZRU95GNGQ1XK5GLhBFZJ8mdZnLR
 eV9J3xAXTWax04FuSs77NVBQO25GD1DCBnXA4W02rhLdb9P+veKNhk/6JGWsnp2L6uJkh++
 EZp2AjqswlQPVaaV9gQA7rfkNUjnJQaISdI2fLGGu8ldoAMzh8RwPYpltIt6SCHx3X/F9EC
 3PVUYWux2Eaf2tT5Y/zEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/qeUXCUQN+o=:ex7CMY0mVgu+nS8eNQXWa/
 Snss1QljC8MEUUuSA5qr5vCfRvlIFKvDJWoTGG4YXcBnNOY0TH0pvFTPzOOkOFz5HeI8Vrn9N
 07wcZ56bL/AYh1bXB4qJjFceEOMfe12H6/lBpWH+tpayt7V2hmibH8bzcJQjMizPULnboSQ/4
 uXoQyXWQ9TTRbcWFwM6FrNNm0CAsUlkgsdvckbcymZy40LKIycnLGK2Mqsb1BFfeejhCyNxhu
 9BzpxlxEoWSiHGywp58B4BKJpt43/MrOoFc8uK/ZF4XY0v56YztDSD+bYljWykGbsK8AHNQLM
 2fnPeXTeZWASmWVGu0ScgtrPOQ3epbNl3ReoLkDueoMpATeaMH46VcjBG50CK8UnHRaI73Wr2
 E+We6EHFqxhrJp/jMKLifyjBpJGeCgW7j5n4a0NiwvBWTy7wXHRV1PrFBwuRv78zGTjDlKojw
 Agqi1O6KiK/+8NItnsbCQx1CMmwm/t/JsVdQtj6E+B9Wtzlx7X0BMWqaeX/cBHHL/wwj0T4To
 YDRq4NAeYn3GuX7awsPvaFTBOqmGsendcnlWdutGL1QZRxzmmAy3dfDW05uVhglXiYjrhhEH2
 TC0mz5YnHZSDJGYcjBidO+RJhA/igO2WxNnqPB/E9+83E0iNoQt7XCwAc1aWUTbz4vLtgHhvX
 oAe2Q9Mze3EhHCUS58YlbtjC61h2b+2Pj0dHcJ9K2UlsCjI+qmgkA9C76vsjrrUbGv4vIS7OI
 A+DxiqNwZCfT8W26PxoMcYBUBZIH5PgkhWpm4Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/rtc/Kconfig | 82 ++++++++++++++++++++++++++---------------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e1a1f2b..f7d2553 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1211,8 +1211,8 @@ config RTC_DRV_SPEAR
 	depends on PLAT_SPEAR || COMPILE_TEST
 	default y
 	help
-	 If you say Y here you will get support for the RTC found on
-	 spear
+	  If you say Y here you will get support for the RTC found on
+	  spear
 
 config RTC_DRV_PCF50633
 	depends on MFD_PCF50633
@@ -1309,10 +1309,10 @@ config RTC_DRV_IMXDI
 	tristate "Freescale IMX DryIce Real Time Clock"
 	depends on ARCH_MXC
 	help
-	   Support for Freescale IMX DryIce RTC
+	  Support for Freescale IMX DryIce RTC
 
-	   This driver can also be built as a module, if so, the module
-	   will be called "rtc-imxdi".
+	  This driver can also be built as a module, if so, the module
+	  will be called "rtc-imxdi".
 
 config RTC_DRV_MESON
 	tristate "Amlogic Meson RTC"
@@ -1475,12 +1475,12 @@ config RTC_DRV_PXA
 	depends on ARCH_PXA
 	select RTC_DRV_SA1100
 	help
-         If you say Y here you will get access to the real time clock
-         built into your PXA27x or PXA3xx CPU. This RTC is actually 2 RTCs
-         consisting of an SA1100 compatible RTC and the extended PXA RTC.
+	  If you say Y here you will get access to the real time clock
+	  built into your PXA27x or PXA3xx CPU. This RTC is actually 2 RTCs
+	  consisting of an SA1100 compatible RTC and the extended PXA RTC.
 
-	 This RTC driver uses PXA RTC registers available since pxa27x
-	 series (RDxR, RYxR) instead of legacy RCNR, RTAR.
+	  This RTC driver uses PXA RTC registers available since pxa27x
+	  series (RDxR, RYxR) instead of legacy RCNR, RTAR.
 
 config RTC_DRV_VT8500
 	tristate "VIA/WonderMedia 85xx SoC RTC"
@@ -1699,21 +1699,21 @@ config RTC_DRV_MXC
 	tristate "Freescale MXC Real Time Clock"
 	depends on ARCH_MXC
 	help
-	   If you say yes here you get support for the Freescale MXC
-	   RTC module.
+	  If you say yes here you get support for the Freescale MXC
+	  RTC module.
 
-	   This driver can also be built as a module, if so, the module
-	   will be called "rtc-mxc".
+	  This driver can also be built as a module, if so, the module
+	  will be called "rtc-mxc".
 
 config RTC_DRV_MXC_V2
 	tristate "Freescale MXC Real Time Clock for i.MX53"
 	depends on ARCH_MXC
 	help
-	   If you say yes here you get support for the Freescale MXC
-	   SRTC module in i.MX53 processor.
+	  If you say yes here you get support for the Freescale MXC
+	  SRTC module in i.MX53 processor.
 
-	   This driver can also be built as a module, if so, the module
-	   will be called "rtc-mxc_v2".
+	  This driver can also be built as a module, if so, the module
+	  will be called "rtc-mxc_v2".
 
 config RTC_DRV_SNVS
 	tristate "Freescale SNVS RTC support"
@@ -1721,19 +1721,19 @@ config RTC_DRV_SNVS
 	depends on HAS_IOMEM
 	depends on OF
 	help
-	   If you say yes here you get support for the Freescale SNVS
-	   Low Power (LP) RTC module.
+	  If you say yes here you get support for the Freescale SNVS
+	  Low Power (LP) RTC module.
 
-	   This driver can also be built as a module, if so, the module
-	   will be called "rtc-snvs".
+	  This driver can also be built as a module, if so, the module
+	  will be called "rtc-snvs".
 
 config RTC_DRV_IMX_SC
 	depends on IMX_SCU
 	depends on HAVE_ARM_SMCCC
 	tristate "NXP i.MX System Controller RTC support"
 	help
-	   If you say yes here you get support for the NXP i.MX System
-	   Controller RTC module.
+	  If you say yes here you get support for the NXP i.MX System
+	  Controller RTC module.
 
 config RTC_DRV_SIRFSOC
 	tristate "SiRFSOC RTC"
@@ -1757,11 +1757,11 @@ config RTC_DRV_MOXART
 	tristate "MOXA ART RTC"
 	depends on ARCH_MOXART || COMPILE_TEST
 	help
-	   If you say yes here you get support for the MOXA ART
-	   RTC module.
+	  If you say yes here you get support for the MOXA ART
+	  RTC module.
 
-	   This driver can also be built as a module. If so, the module
-	   will be called rtc-moxart
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-moxart
 
 config RTC_DRV_MT6397
 	tristate "MediaTek PMIC based RTC"
@@ -1799,39 +1799,39 @@ config RTC_DRV_PIC32
 	depends on MACH_PIC32
 	default y
 	help
-	   If you say yes here you get support for the PIC32 RTC module.
+	  If you say yes here you get support for the PIC32 RTC module.
 
-	   This driver can also be built as a module. If so, the module
-	   will be called rtc-pic32
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-pic32
 
 config RTC_DRV_R7301
 	tristate "EPSON TOYOCOM RTC-7301SF/DG"
 	select REGMAP_MMIO
 	depends on OF && HAS_IOMEM
 	help
-	   If you say yes here you get support for the EPSON TOYOCOM
-	   RTC-7301SF/DG chips.
+	  If you say yes here you get support for the EPSON TOYOCOM
+	  RTC-7301SF/DG chips.
 
-	   This driver can also be built as a module. If so, the module
-	   will be called rtc-r7301.
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-r7301.
 
 config RTC_DRV_STM32
 	tristate "STM32 RTC"
 	select REGMAP_MMIO
 	depends on ARCH_STM32 || COMPILE_TEST
 	help
-	   If you say yes here you get support for the STM32 On-Chip
-	   Real Time Clock.
+	  If you say yes here you get support for the STM32 On-Chip
+	  Real Time Clock.
 
-	   This driver can also be built as a module, if so, the module
-	   will be called "rtc-stm32".
+	  This driver can also be built as a module, if so, the module
+	  will be called "rtc-stm32".
 
 config RTC_DRV_CPCAP
 	depends on MFD_CPCAP
 	tristate "Motorola CPCAP RTC"
 	help
-	   Say y here for CPCAP rtc found on some Motorola phones
-	   and tablets such as Droid 4.
+	  Say y here for CPCAP rtc found on some Motorola phones
+	  and tablets such as Droid 4.
 
 config RTC_DRV_RTD119X
 	bool "Realtek RTD129x RTC"
-- 
1.9.1

