Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979A0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F90222D4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbfCKNam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:30:42 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:56983 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbfCKNTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:30 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MUXlG-1hTd7A2UjI-00QV2Z for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:28 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 008/114] drivers: ata: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:20 +0100
Message-Id: <1552310346-7629-9-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:BgbOIhMFFcVriP51wL/nqhwt6+rYqLzeM58PZMWlIZ3pLkUzdAG
 /F9ybxpZXcZOrSOa7rkYpOiW/DC4L+iA1/iDkJ38z5xhoujEUTMqvBp+aLO6c0JTU0wkeGz
 uUC8JoLlpdu6MuaHO3axpycqGe4reAclNEiosVN5Es1bM0sVZ+rbNzkFPc4O7k96FWtcHTp
 T2XQGd2yF/H7uXmjwnxgw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MzCUQFtykQQ=:Gqi8UF/kTu4O4CgeDXBeu4
 6FfbNu/a6bt8SvsTmeLjzaXqSA9D6ymZ9J3HiL/VslUBrbQ0tRSrBDS84V4FK8rOVudN8n9nN
 sVB87b43KDazPYwrGiG5f3NAzUwfIkJFRwF66oxAgXCKyvQVX2YbOJr1u1P44dpLkKkJNyeku
 0u5cqt+Jt7YqqTnohllm1XE2oT3sIAelF5b2JDtgC0XTqL6FWndQiaidVi4V/lUgAzeqRhVFE
 jzzAWcJSRcXwMxD/AemIsN27mP/gucwxbZHRDfCLo1S1GDzFiPW5qT16Qqp/MWRpuSLn67/wr
 PNYTfhv5D0eihVEJElAsmYscNYetFMqNXE4tPrD8Zfje4XetNHtXmaNsXfB36aEEZj/awzGKG
 6pFret+N9DQSDygGoPsTkpZlzgRIvftTcamOSNwcsEd8iplWYeU70MTh+5PAcr8WMmWI1x/Ak
 PgDustE9Ej/GWt8+pmU/PtfH7m+RiMxx+M2EHpS1puxE93+36oxEnEN+fU/zRRgAlrh5QWJwk
 uyRErB6U+E7C50Hr4O6zmiZO6yXBN2X9ANCZBTVrmgYMJvJpLC58FS05KqlpzgLaKBS6f/qMj
 QCT8q5z8l5ch3hepcU86uFtLX8Pv7u+7yTk3AuI+11fkEmXbz32PLfOSuUpcxvMjsjvvEKDHu
 y4BMsbaUy9ibO+ZGJQ87JzWjIaf8Vnx8P1yHtnrxDZIZsoKNy2CYkT08Gp2nYs1QkSRpWVF6H
 LrvAkew0tsFFgRN+c9A/O7tYKPtwh3zpRaZ+7Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ata/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index a6beb2c..e0a41b1 100644
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

