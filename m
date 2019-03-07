Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C45C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CE120663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfCGB3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:29:00 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:40255 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfCGB27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:28:59 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mq33i-1ggLBz2nzu-00n6BH; Thu, 07 Mar 2019 02:28:57 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, linux-ide@vger.kernel.org
Subject: [PATCH v2] drivers: ata: Kconfig: pedantic cleanups
Date:   Thu,  7 Mar 2019 02:28:56 +0100
Message-Id: <1551922136-32503-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1551896264-21374-1-git-send-email-info@metux.net>
References: <1551896264-21374-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:axr4IhAebf4UgrKVFqep+mTS2AeYVMHMR0bd56t7oEIZJ054scz
 PBLQNodVbfBJyCCEQPirxoTczBNqFo4n26eZKUGT9uyahH9FKb/w3VY9nkiKzbs4FNe5jgU
 5rSw3fRDZH+TDjPvNh2oDFoAxtAElAjXT4w7oulh9pUmyFCCxnqqsjUmqSPF1+Zjyd4TqPN
 Tmv5e2akeiAqdqIbrzLzw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0ryGPHUrATg=:8Ga1BLyexboXH+fyEDBwlo
 p0paOO0pPL0oyGN8WMCK3dTpQOK12gVfzguO7aVQWblHQc/DifTDIzHIj8AjN9BVDqZKgrpax
 TnD4hK5+mkx5p7gl3OGYKW7z5urawyrloSztJZ1+uLuntFvLylzigYkIAVlgA++Aqucfy+s8q
 Vk3+010hoboXr5bpDDGOEb6C1LB6LKQ9OEr6E1tV/h//Z+veOJTFANAeQWmayNuR3JoJni7+a
 FwMHrNTm/Mr8sTGCgozBhwVpz/chcN01TelKD1zvb7+dMcVrSz+hNRnVAc+W38eXw02msrL++
 Hr1hYekpv2D/4BfPN0aW3l5V5cndRjMMfuqIIJZghVV3eMjSbeRSC+ZFunqoUPO7gS6wF0gnX
 fkpVolGQrF/2mAp8kb0o53yJY0ECBVFvD55h4M3VwkeM5Gk39ijeFmerXx3c9oEnxVeNSwRuD
 slwdjlslnuhFu0YzbIF+cuw2OYACAZZtzmToiOCDlEOa/RWpQvJ8bchBFK/8HpFABMwwq5Or8
 tinYg98pblt1+/5vnKDz8eVSbwzrdcoXQ6ILKtPHZpce/28bEZnEjsCeK7hCgS6vcTZQS1sMD
 7mzVEvyD0NWZXEQvgrgeU30Xg/DD9shpcOSmAGw8UAbimOXYFTuz7H1BzqZilYE1HGvSqtZof
 qMjFMsWm4hrug1zFKzVNmvDJ7xjcrjPAfAoITGOzBWLbLIR+Q62/HFWky1jLwMMH6/P8dn6F0
 o2KuH7s3qdarUVNg9yZTM3zcmoloHd31Z2TT+Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so just
take damp cloth and clean it up.

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

