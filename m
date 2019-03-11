Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EFAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75A720657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfCKNTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:19:37 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:54545 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfCKNTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:30 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MSbp1-1hW79k0APp-00SxsY for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:29 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 011/114] drivers: mmc: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:23 +0100
Message-Id: <1552310346-7629-12-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:YyEcUwyj1ytiAeulPTnMlfLvhJcjQJuN7b+Z55xnua2y4+TRQ5H
 hcZK9IyV8Nq7WZkIyCY9+BbPQLePLOvkF9GFopnfdQcyhCImyUs9gMHx7wh9aEXy8+AKcuX
 tXYqRcjTggm7M4r8JJ+CNeOwXWnEiPceRCVhxag2t5iYjoxH7EyKX6bV/jivlHnewbCY97v
 kS95B7Kw06s7ctrVwO0hA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xGY8lucXj4o=:q/HT/KSfi0wfuE32rqsC0v
 2GBgiHUjTah80KVjPaL0VpeptTgnVVVjUy7nonq8r49CaqyERF5ZyzzC27snMq5HG+bmnbbW4
 D4a0I9elvOLSPE8zJW/4LEeuHaeKM9R/kOuMeeEt8iC3tBZhws2TieCwLd0aThuH3Uyhb3zUg
 iw6tYSIZThfJEI4/B7JFZvMgTv89DZi5shBNgzjOgBHf4HdA+d7Naj/Tp/2+j/CMaW/qI3f7w
 irVPni78Vx5OorEPsqBHOC0Qg+De8+yTMSCQ1x/qh/gM6vkB3hkNVYvPZ42l1iX9mXEQgYwu8
 Abxsu951xzNeODh9SLKHHOQu9kwAQ4Q1eSkJFS3HbokOQZvzQlJikNY47NeJIF+IcZD5NVP0f
 NIelUMqInk27DH3BvtIjZxtr6NHB9u3aOyd3pjnr+1IQZVFiTfvdwIkkaCMSXqQ0B1Er2McnV
 fdcWTtDUrp2W2yOwdyuX0KCLCduLSJ33WMzfujt3tMQ0XXcTDMwLSss92efnZMxfHBnlNHsCg
 0bwmZuB9Bt9a+nI4yJYar0H+aUSRAE6ZyDzI9ACw23oMENEd9BlfVI6jHTVgR2nDYcp2Jd3dp
 v2Lt/WBYap6cAbmAoMGuctMW19hfQvUC8OTlDbah3MPzA4lm9HHkcAATTR5ktfTdQObFXupeU
 iIe3uNIOgbXy8upKvxH6Ayzg2yJMoYgWjemwBkjNUIT5v0L70oDYOyaAt61H0kemCXEO4FBOW
 3xWcZ9IbKdy7xxa+/UDPKgVUHEvthF/nBa28iA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

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

