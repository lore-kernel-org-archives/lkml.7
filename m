Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0725BC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D86B9206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfCFSRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:17:49 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:47083 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730823AbfCFSRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:17:47 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MfpGR-1gZQAK1cfR-00gFeF; Wed, 06 Mar 2019 19:17:45 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org
Subject: [PATCH] drivers: ata: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 19:17:44 +0100
Message-Id: <1551896264-21374-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:qPwF86B305hCCg1GjMiW38k1KMW5JRZ5QR38hRmw97OLeaOH0lc
 rHUF34tWaZJYd1iya58oCnGPE0wL4IClm83mqJJ34GPwVTrP4kalmj244BhfvIZQDrEVOU/
 rFSWi8lfhXzb+7eBato1jzEENcnBJkoM1qpm4DXKcBASa95eKtME9lCBSo/wuw/quAuRUFZ
 jmkddFJd8q9xmlf49oQVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FJmf9WtrlJY=:mvM+69Szmc/bG+WZNZZlAz
 QZFFaig4NqQ821Els5PdqZJbEAQQkrOpbaLGtgZp74yPFeCYFpjOcR/nLILTAE6+8f8wGLkwh
 aYxuHNA1OswKoQ6lH+UiaDtCDbRpCvZzJvZBgZAKY8KPYufoPCj/2J+CqFho7gxLRDLCXGwQu
 N8amOqoCsv/VY785bR3FGpA1l6MgGs4cdI4wsusydV1l6yf+khPdSu5KDWCw/7FtLDxDuHcM0
 W4VF3I2Gwtd2kLCTHXV6iyiMHDbmGPwEkROVbb6UaEJ7qTfiF3OqrgWCTsZGn8P2kY/kxQggD
 f69OJGgoHKl/vq1xEHVAwiljBC0AE10Ihsf1bs1gt4B4NZwOz+2xAhHKH7RP0HepKBUJPzY0h
 D1IwlNEI2/uGlVZvkeVsNDx0bpL+sBbgmlf8RE8mJm8XxrQ5nk4FOPzZdFh7y0Xt+KhHoMATp
 xuJm01inQbxZITAL+y4gQNdjD7iGe6gN/t5qQ5vFTveRni3yJXjiZx+DrGqQ8Z5Zc557gPgVz
 cGQ/L7WuYlwsBRTj99QU1jpk07c73WPWV9pRvamJmdhnGDePBsyfgy0mCMls29pbvYMKERBZI
 W+UbXmJdbtXicU0U4Tda01+gcvvNoB7Wl0W2AEZp1kCZT0XyWGt8aYZOWWYIPAdCvRxV6huOr
 PhXO3drFaAA9gM11DTiFh2ogD1btk5zk8wsfasRyqYPWT0TNEfHgH6zc+F7zi1zEB1k6OX5nD
 LjGxft98gL5fiu0GEkU11mOCIVja/crfivWJSQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 8218db1..ae72350 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -32,7 +32,7 @@ menuconfig ATA
 if ATA
 
 config ATA_NONSTANDARD
-       bool
+	bool
 
 config ATA_VERBOSE_ERROR
 	bool "Verbose ATA error reporting"
@@ -222,7 +222,7 @@ config AHCI_XGENE
 	tristate "APM X-Gene 6.0Gbps AHCI SATA host controller support"
 	depends on PHY_XGENE
 	help
-	 This option enables support for APM X-Gene SoC SATA host controller.
+	  This option enables support for APM X-Gene SoC SATA host controller.
 
 config AHCI_QORIQ
 	tristate "Freescale QorIQ AHCI SATA support"
@@ -256,9 +256,9 @@ config SATA_AHCI_SEATTLE
 	tristate "AMD Seattle 6.0Gbps AHCI SATA host controller support"
 	depends on ARCH_SEATTLE
 	help
-	 This option enables support for AMD Seattle SATA host controller.
+	  This option enables support for AMD Seattle SATA host controller.
 
-	 If unsure, say N
+	  If unsure, say N
 
 config SATA_INIC162X
 	tristate "Initio 162x SATA support (Very Experimental)"
@@ -695,7 +695,7 @@ config PATA_IMX
 	depends on ARCH_MXC
 	help
 	  This option enables support for the PATA host available on Freescale
-          iMX SoCs.
+	  iMX SoCs.
 
 	  If unsure, say N.
 
@@ -704,7 +704,7 @@ config PATA_IT8213
 	depends on PCI
 	help
 	  This option enables support for the ITE 821 PATA
-          controllers via the new ATA layer.
+	  controllers via the new ATA layer.
 
 	  If unsure, say N.
 
@@ -732,9 +732,9 @@ config PATA_MACIO
 	depends on PPC_PMAC
 	help
 	  Most IDE capable PowerMacs have IDE busses driven by a variant
-          of this controller which is part of the Apple chipset used on
-          most PowerMac models. Some models have multiple busses using
-          different chipsets, though generally, MacIO is one of them.
+	  of this controller which is part of the Apple chipset used on
+	  most PowerMac models. Some models have multiple busses using
+	  different chipsets, though generally, MacIO is one of them.
 
 config PATA_MARVELL
 	tristate "Marvell PATA support via legacy mode"
-- 
1.9.1

