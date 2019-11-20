Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE71C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FF92088F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574270329;
	bh=8bej6lv9Kxl1TI/QbROpg82CwWltC4MaUmoFrInWIhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=tCv4ngv6Y+7HHRCnQDuCMGTuaMPq8zdrlFA2fTTo97iqGJdO3F0vEzKi9ZGI150ep
	 lHkyo3xCIJftyxUtSsIRWnwMdY6ykIvXcPPnCosiP6jvJRpYRl6BGDyF5ZgDMwCbLc
	 g3fuGR9VxPzO3UPMs27JcUKngdOy0tG+QLKhu60g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfKTRSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:18:48 -0500
Received: from foss.arm.com ([217.140.110.172]:43450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbfKTRSq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:18:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C3D81045;
        Wed, 20 Nov 2019 09:18:45 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09FC83F703;
        Wed, 20 Nov 2019 09:18:44 -0800 (PST)
Date:   Wed, 20 Nov 2019 17:18:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Fix Kconfig indentation" to the spi tree
In-Reply-To: <20191120133916.13595-1-krzk@kernel.org>
Message-Id: <applied-20191120133916.13595-1-krzk@kernel.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: Fix Kconfig indentation

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 554bbe726ce0ef692cd95fedd5730c69c1189138 Mon Sep 17 00:00:00 2001
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Wed, 20 Nov 2019 21:39:16 +0800
Subject: [PATCH] spi: Fix Kconfig indentation

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Link: https://lore.kernel.org/r/20191120133916.13595-1-krzk@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1

