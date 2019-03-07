Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5CEC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D4E620663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfCGBeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:34:13 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:51899 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfCGBeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:34:12 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MeTsQ-1gTk9G3aw0-00aSDu; Thu, 07 Mar 2019 02:34:02 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, linux-ide@vger.kernel.org
Subject: [PATCH v2] drivers: ide: Kconfig: pedantic formatting
Date:   Thu,  7 Mar 2019 02:34:00 +0100
Message-Id: <1551922440-2245-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1551899004-25283-1-git-send-email-info@metux.net>
References: <1551899004-25283-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:nM0ECydPc7QHxcv9AUIzyuIUYADEiVqVTeaJ44Ea3n4NvKnrA9a
 Ydj2TQ8bdw6Lh5xMdCnhHur0m0SXyUQmOqo0AnwjtPw72eXM1mc64/j3b7lhTTHLI2h+hgq
 G/4UpsMdiIdUNuDLWR9QbE7WhKg/E1RtJdtdXm50GlYp2/MHNN6AF6eCLn8hkVUTBAbPwRN
 pL0s/V+PUEOlhF/VLg0PA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Er/UcgieWl4=:xR2BImY2ICLlTmZbhs9VLH
 NpCXX5lND2M5aupQoPQYzLtLP5FuIHe77DYvfoj+mcI1gYiBwpVSlB1SyPSFysG1WZbsrooRy
 thcf/+JpmbDgZijtBifqXu54/KZO8XDPa8Ipj7QeZuJeVWxH56GWQ83do6Tvk33XPRKwypCC5
 qBqVcKrvuH5zGhENMo0yAKtcNr8Nhnh2rNG7aKn0KUUO6NikJGsyLrx7sS4eGxYaEycuGLWO/
 7Xz1nEAZXcvUl1jIe5w8xcJ16/eqPcRc7FIzIbMw0in8jg53qZXUeyJ60Rw5RTer+VI+roOyX
 5VkpVQ5ksiM7xAeTBiG/dkaT/GyfcFgOIRh5AjArBgCwKRp+a9evOoWd7oaLGFOVX3kzMA4dS
 MNZrDIjaSNwMMuF9Tb8fcbP5/tc2mCzHz5fKvjOU/xh2ricEePbWji4bMnLBE0Rjdbp9GpIhr
 LFf2OLJHKGoN5pl2gO6cY0OOe69eKxvvF6pQaWtun7qEUhbEXfmWqQVFOP7zuUgf1k9Pv4KP4
 mXNRq8t58sZIINZNFlj5k4+8QQsFoWpybEFwhB/8qjkN3ODSvUXDT49r7FfV4AtJP61NTWUxh
 sUQgYdGzmhF6X3oxlgSzI26/copzmcKtoedTscsyYIy3yDJkoDCi5h2cQfW9K/vFhwASXWhFw
 jyGdm4LtKRtrNqBvedhB9+8j2/ZKvy6yDV4gCpAA+nEFJWreDD4Uv002E0IrFOEp50x7OAL3i
 F8j6PE2PEAoXsEX+zJGRsVepnNOCqX9fZJuwEw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so just
take a damp cloth and clean it up.

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

