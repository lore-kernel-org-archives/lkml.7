Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBE0C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5775C20645
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbfCFTDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:03:33 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:55757 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfCFTDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:03:32 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1McH1O-1gVqRG34Ae-00cgh8; Wed, 06 Mar 2019 20:03:26 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, linux-ide@vger.kernel.org
Subject: [PATCH] drivers: ide: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 20:03:24 +0100
Message-Id: <1551899004-25283-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:WNpulOgKoXVrAzphUiwBZmxWmyMdHmrNWsEc+fsXP3M74yt0vZs
 dbMORMhZEILBzRcZ8kiISUwhqt+LqdFgC+W1sjq0lwT1BQD8e9Xs3lvSlRcS4HpsPxJVhVy
 jHx8HAmkn9AX3S4Js8VqT1lCVXghtr3F8s7OTTEfiCO9v0kJ4Tl8Xomq/jmHNibZ5yrL2oh
 padynX6JGSjm8z87AXQgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r5SRs74qSO8=:050ma2CC4pSs91SK1Z0kK+
 zeRdGhrV4pxR790t7s0QAgFak/yLsGfPInEmvW1i3FBma6HUGusUYoixLNn3aKbCVh5PCz3vG
 GgVVt7hvIuCetVviiSEaQx73gGgvjTuTssE7jVnZJPHTrgXclrWm4pV6AgnSqH9H3B3wKmEWC
 8weB+W2c182imwc/xfUCBqaYxT+dlSeWvJHMosVHBeK4P3RQVCn8urNBcaIEPKGAUPB9FEviV
 JMCvBgZ87qLgH2itwzirjHW0SbGZVqyuTg8HAum6VLMV/vNCzCa6FvET4iKpMkZ8njEialdsW
 xTSc7JaXQn0arGC+9h37FvVvVJh/GkbcQhx/5+DJ7u4d2QbU4uEiCD4qitRXe+dz/Pe6T298V
 vRQUGXaPBI13nqlGXxYlt+ObCjjC722sWj+XhvY3smzK3TfJDNV14s0UJpb9YmPFyL8ZgM1bi
 dJ61SUPCqpeGlBmGGBDwK25eX7CHzfi5x6fYZ+mdAWaqHBIyORn/GlXfm1xxjvyweMY9OqKMq
 mkBOlzt7JZkIbf8vCcZOabdEgVILcHT5KPvnohZur153iyKLADXScemX302xsKVRCUrEY1quG
 kHnhV7w+M06r0JzOY+asU7Ob/Mq7u/Pw1Jr17SxmKQ4JEbK+7bwNBdLCswQcL1UPwO1ESS796
 J48SCr1V9pquTXiPbB4NUKAXtTAXPsf2WRYeK3tytqYUhhVKjlq6tW3mwSeDkMA4YMRgV+KsA
 sJEOB5D3VYVbIkqo2xPNK0hMfD4+U1iP9VBIGQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/ide/Kconfig | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 901b883..19fcd07 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -320,9 +320,9 @@ config BLK_DEV_OFFBOARD
 config BLK_DEV_GENERIC
 	tristate "Generic PCI IDE Chipset Support"
 	select BLK_DEV_IDEPCI
-        help
-          This option provides generic support for various PCI IDE Chipsets
-          which otherwise might not be supported.
+	help
+	  This option provides generic support for various PCI IDE Chipsets
+	  which otherwise might not be supported.
 
 config BLK_DEV_OPTI621
 	tristate "OPTi 82C621 chipset enhanced support"
@@ -516,7 +516,7 @@ config BLK_DEV_IT8213
 	tristate "IT8213 IDE support"
 	select BLK_DEV_IDEDMA_PCI
 	help
-	 This driver adds support for the ITE 8213 IDE controller.
+	  This driver adds support for the ITE 8213 IDE controller.
 
 config BLK_DEV_IT821X
 	tristate "IT821X IDE support"
@@ -671,20 +671,20 @@ config BLK_DEV_IDE_PMAC_ATA100FIRST
 	  hard disk and hdc for CD-ROM.
 
 config BLK_DEV_IDE_AU1XXX
-       bool "IDE for AMD Alchemy Au1200"
-       depends on MIPS_ALCHEMY
-       select IDE_XFER_MODE
+	bool "IDE for AMD Alchemy Au1200"
+	depends on MIPS_ALCHEMY
+	select IDE_XFER_MODE
 choice
-       prompt "IDE Mode for AMD Alchemy Au1200"
-       default BLK_DEV_IDE_AU1XXX_PIO_DBDMA
-       depends on BLK_DEV_IDE_AU1XXX
+	prompt "IDE Mode for AMD Alchemy Au1200"
+	default BLK_DEV_IDE_AU1XXX_PIO_DBDMA
+	depends on BLK_DEV_IDE_AU1XXX
 
 config BLK_DEV_IDE_AU1XXX_PIO_DBDMA
-       bool "PIO+DbDMA IDE for AMD Alchemy Au1200"
+	bool "PIO+DbDMA IDE for AMD Alchemy Au1200"
 
 config BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA
-       bool "MDMA2+DbDMA IDE for AMD Alchemy Au1200"
-       depends on BLK_DEV_IDE_AU1XXX
+	bool "MDMA2+DbDMA IDE for AMD Alchemy Au1200"
+	depends on BLK_DEV_IDE_AU1XXX
 endchoice
 
 config BLK_DEV_IDE_TX4938
-- 
1.9.1

