Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A211CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75031224FC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257163;
	bh=vPa/cGDp8ajSRH9qXDMIZ1zWolJE48+30OeYlmw91PI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=s3SNLBei8qfhNIhcvdK6aJSrOLqOv7r4v7ouAfchwZuS+xtsf6QwBhkkWZrAJBSll
	 oV3Fv2HD+YA2WIeQhKJLAzWq4WjQhOKGddOmqiFVr6moO61oh6hAglNiMyUL/XWDK2
	 SCHA8hozzXCLrgrsmumlHWZRpmo4xGCW2Y9HQwvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbfKTNjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:39:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:46940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbfKTNjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:39:20 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB547224FA;
        Wed, 20 Nov 2019 13:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257160;
        bh=vPa/cGDp8ajSRH9qXDMIZ1zWolJE48+30OeYlmw91PI=;
        h=From:To:Cc:Subject:Date:From;
        b=AiIyy8tMchHKypt4TqS430UZZ4z974P/RBkg+n9kle5s69qZUyNaO5w4lmWyXSkf0
         rBiUDW2kChzjbce4MHlRM1gSTfsiQBTzD2uKUOgI1q6KwhpNM8d3mbxxrgskd+b78T
         2c1xFuv9CUGrRhpi6ASFeFp4uyN++bzZ6IHHQVbY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH] spi: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:39:16 +0800
Message-Id: <20191120133916.13595-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/spi/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 6c0c1f55bd71..870f7797b56b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -144,7 +144,7 @@ config SPI_BCM63XX
 	tristate "Broadcom BCM63xx SPI controller"
 	depends on BCM63XX || COMPILE_TEST
 	help
-          Enable support for the SPI controller on the Broadcom BCM63xx SoCs.
+	  Enable support for the SPI controller on the Broadcom BCM63xx SoCs.
 
 config SPI_BCM63XX_HSSPI
 	tristate "Broadcom BCM63XX HS SPI controller driver"
@@ -235,11 +235,11 @@ config SPI_DLN2
        tristate "Diolan DLN-2 USB SPI adapter"
        depends on MFD_DLN2
        help
-         If you say yes to this option, support will be included for Diolan
-         DLN2, a USB to SPI interface.
+	 If you say yes to this option, support will be included for Diolan
+	 DLN2, a USB to SPI interface.
 
-         This driver can also be built as a module.  If so, the module
-         will be called spi-dln2.
+	 This driver can also be built as a module.  If so, the module
+	 will be called spi-dln2.
 
 config SPI_EFM32
 	tristate "EFM32 SPI controller"
@@ -748,10 +748,10 @@ config SPI_SYNQUACER
 	  It also supports the new dual-bit and quad-bit SPI protocol.
 
 config SPI_MXIC
-        tristate "Macronix MX25F0A SPI controller"
-        depends on SPI_MASTER
-        help
-          This selects the Macronix MX25F0A SPI controller driver.
+	tristate "Macronix MX25F0A SPI controller"
+	depends on SPI_MASTER
+	help
+	  This selects the Macronix MX25F0A SPI controller driver.
 
 config SPI_MXS
 	tristate "Freescale MXS SPI controller"
-- 
2.17.1

