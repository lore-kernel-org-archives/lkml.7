Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3B0C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7686206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfCFS1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:27:55 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:60681 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfCFS1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:27:55 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mzhax-1gorg90z3Z-00vcuz; Wed, 06 Mar 2019 19:27:52 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Subject: [PATCH] drivers: mmc: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 19:27:51 +0100
Message-Id: <1551896871-30654-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:XdYhKOSIFGbb2eB8ETSq4xrlyxiP2WzP8xSB+a+oWcGzPk++4it
 S2Anj3YgAgLQv8107JhF/D6I/+EWWdvC2+PZttTZoaX8H/4bO2242dL4oO8Z4+i9NzkcvZe
 OdEbi2RgJuihliwgpCdDcBOicTjtnTj1fpYXa5M5vWEwE/bESTgDHD/ZJJqF05X4v881DB6
 JSym5Qvh61ALnMg7Z16fA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/9lhF4260mY=:A7pJ/IlYtsu3j0cWOG10b0
 xRyQpZHx7W0oRRf7aAFHaJQ/foWTryoUf6offp7q3IPVnnq0AXWGA9JuB4JoXpREc2vFOSBH2
 C+GqX+ZyZF3BHcCvYGUa5S7JsIA28GFz7k3YvEsJBD6Fzp8+QAJxfYkAln4/c7BaevJXNmuv5
 Ek48Pgdm0sfISPMt/4H7K9eppBmvOdV8WbuCKwCrWaTlLp595givbsSmoWJTfaq0QCMB2iPMG
 nzsd6pBkWttjhVdQAA3MDgadMmSotXjxbU8RhpuBrEzL270B4L6M11wyy+v5Ew0eVzqk2FpHl
 pRCN7oxTqx6rw64V0eFdgl0waaF13gPjg4XMaq+rmqNMHqB5TIuP1E37XMtgTzsMqiTjuEczv
 mWbHoz0qMOrTju0aSpTytza+cmOHo06SD1dY4PXuR24CEomiGTOTuBOd/PdoiicCL51D6KH2I
 bQO40u9huphfaqVWekN5DkW2sPwOjigDZGfYfrRYiU4EaQ26AIWBG5ckBeXzjfiBOdJB9ch8j
 +VZEgpueuptR93QxosnjQuzWhBWbuZH9uXqlZoKT3nw7w5gAI7t2Pgj928mhAUQe56KMxlGyP
 KNwTg66huFxRU8+n/guSfjABhw9/J5DaGA071wQ7IbQbt6ZMEsbGcWulK5sr++djnMjYmzagA
 rueynsDaqqc7qfILIKRNdahie9bvv6rVCjpaWjMn84y2WTEDUVBKUukmoh6T88E10+CX1sPxG
 w29TNzw2455PlJEL3wWyCws1yL/4sD5QddB7Zg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/mmc/host/Kconfig | 43 ++++++++++++++++++++++---------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 28fcd8f..de7a38d 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -437,7 +437,7 @@ config MMC_WBSD
 	depends on ISA_DMA_API
 	help
 	  This selects the Winbond(R) W83L51xD Secure digital and
-          Multimedia card Interface.
+	  Multimedia card Interface.
 	  If you have a machine with a integrated W83L518D or W83L519D
 	  SD/MMC card reader, say Y or M here.
 
@@ -515,7 +515,7 @@ config MMC_TIFM_SD
 	  'Misc devices: TI Flash Media PCI74xx/PCI76xx host adapter support
 	  (TIFM_7XX1)'.
 
-          To compile this driver as a module, choose M here: the
+	  To compile this driver as a module, choose M here: the
 	  module will be called tifm_sd.
 
 config MMC_MVSDIO
@@ -531,12 +531,12 @@ config MMC_MVSDIO
 	  module will be called mvsdio.
 
 config MMC_DAVINCI
-        tristate "TI DAVINCI Multimedia Card Interface support"
-        depends on ARCH_DAVINCI
-        help
-          This selects the TI DAVINCI Multimedia card Interface.
-          If you have an DAVINCI board with a Multimedia Card slot,
-          say Y or M here.  If unsure, say N.
+	tristate "TI DAVINCI Multimedia Card Interface support"
+	depends on ARCH_DAVINCI
+	help
+	  This selects the TI DAVINCI Multimedia card Interface.
+	  If you have an DAVINCI board with a Multimedia Card slot,
+	  say Y or M here.  If unsure, say N.
 
 config MMC_GOLDFISH
 	tristate "goldfish qemu Multimedia Card Interface support"
@@ -565,18 +565,18 @@ config MMC_S3C
 	depends on S3C24XX_DMAC
 	help
 	  This selects a driver for the MCI interface found in
-          Samsung's S3C2410, S3C2412, S3C2440, S3C2442 CPUs.
+	  Samsung's S3C2410, S3C2412, S3C2440, S3C2442 CPUs.
 	  If you have a board based on one of those and a MMC/SD
 	  slot, say Y or M here.
 
 	  If unsure, say N.
 
 config MMC_S3C_HW_SDIO_IRQ
-       bool "Hardware support for SDIO IRQ"
-       depends on MMC_S3C
-       help
-         Enable the hardware support for SDIO interrupts instead of using
-	 the generic polling code.
+	bool "Hardware support for SDIO IRQ"
+	depends on MMC_S3C
+	help
+	  Enable the hardware support for SDIO interrupts instead of using
+	  the generic polling code.
 
 choice
 	prompt "Samsung S3C SD/MMC transfer code"
@@ -948,15 +948,16 @@ config MMC_MTK
 	  If unsure, say N.
 
 config MMC_SDHCI_MICROCHIP_PIC32
-        tristate "Microchip PIC32MZDA SDHCI support"
-        depends on MMC_SDHCI && PIC32MZDA && MMC_SDHCI_PLTFM
-        help
-          This selects the Secure Digital Host Controller Interface (SDHCI)
-          for PIC32MZDA platform.
+	tristate "Microchip PIC32MZDA SDHCI support"
+	depends on MMC_SDHCI && PIC32MZDA && MMC_SDHCI_PLTFM
+	help
+	  This selects the Secure Digital Host Controller Interface (SDHCI)
+	  for PIC32MZDA platform.
+
+	  If you have a controller with this interface, say Y or M here.
 
-          If you have a controller with this interface, say Y or M here.
+	  If unsure, say N.
 
-          If unsure, say N.
 config MMC_SDHCI_BRCMSTB
 	tristate "Broadcom SDIO/SD/MMC support"
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC
-- 
1.9.1

