Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C19BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C6C208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708717;
	bh=miw40vYklPd6hqW4TUkNL+XwF74JQ/1MW/vUeGfYWGQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=TekYOxFQeWixME7zYK7UM5hWoZs70aFeaFSw4cm+nqLmXrTYfxpgpP+pZIP5IAEYv
	 r7kIyAFJR6PGohKUkxqZlCb1s1WE9i4EXa6uWSW+XMq5gXlhNIhkyEDjZkkTMe7fT3
	 NmzbP2XwO5wBRnp08KRwfJ/ju23He06j0NdMdErg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfDHHb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:31:56 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43494 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfDHHbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=5XG/PEmpUe1Wg5kuPz4A4uwQ9+8HTR7RfZskFZI5DjI=; b=Ykjp+BBIEIZh
        Kmu4C/rs4MQlLzDRjJh/3TWIc43fG5YZ8EFVm8yTv03zlJClpXsYZwB9CiOPUo1gvl3mbhhOkHsFa
        IAjznXlTAXFkXDB075dFIahJ2KGRpbFuvZQOC6ek8+5kumNxTBrbdV1Y3IJGPTY/JydLoLWFF1Lh9
        EckWo=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOkl-0003wb-Pz; Mon, 08 Apr 2019 07:31:41 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 6E37B441D3C; Mon,  8 Apr 2019 14:31:29 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: add a method for configuring CS timing" to the spi tree
In-Reply-To:  <1554423259-26056-17-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408073129.6E37B441D3C@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:31:29 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: add a method for configuring CS timing

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

From f1ca9992ced71029735784de138f53446363087f Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Thu, 4 Apr 2019 17:14:16 -0700
Subject: [PATCH] spi: add a method for configuring CS timing

This patch creates set_cs_timing SPI master optional method for
SPI masters to implement configuring CS timing if applicable.

This patch also creates spi_cs_timing accessory for SPI clients to
use for requesting SPI master controllers to configure device requested
CS setup time, hold time and inactive delay.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c       | 15 +++++++++++++++
 include/linux/spi/spi.h | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index fd1372fe0505..bf4027b54a19 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2995,6 +2995,21 @@ int spi_setup(struct spi_device *spi)
 }
 EXPORT_SYMBOL_GPL(spi_setup);
 
+/**
+ * spi_set_cs_timing - configure CS setup, hold, and inactive delays
+ * @spi: the device that requires specific CS timing configuration
+ * @setup: CS setup time in terms of clock count
+ * @hold: CS hold time in terms of clock count
+ * @inactive_dly: CS inactive delay between transfers in terms of clock count
+ */
+void spi_set_cs_timing(struct spi_device *spi, u8 setup, u8 hold,
+		       u8 inactive_dly)
+{
+	if (spi->controller->set_cs_timing)
+		spi->controller->set_cs_timing(spi, setup, hold, inactive_dly);
+}
+EXPORT_SYMBOL_GPL(spi_set_cs_timing);
+
 static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 {
 	struct spi_controller *ctlr = spi->controller;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a0975cf76cf6..589f9dc9ac2b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -330,6 +330,9 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	must fail if an unrecognized or unsupported mode is requested.
  *	It's always safe to call this unless transfers are pending on
  *	the device whose settings are being modified.
+ * @set_cs_timing: optional hook for SPI devices to request SPI master
+ * controller for configuring specific CS setup time, hold time and inactive
+ * delay interms of clock counts
  * @transfer: adds a message to the controller's transfer queue.
  * @cleanup: frees controller-specific state
  * @can_dma: determine whether this controller supports DMA
@@ -363,6 +366,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  * @unprepare_transfer_hardware: there are currently no more messages on the
  *	queue so the subsystem notifies the driver that it may relax the
  *	hardware by issuing this call
+ *
  * @set_cs: set the logic level of the chip select line.  May be called
  *          from interrupt context.
  * @prepare_message: set up the controller to transfer a single message,
@@ -488,6 +492,17 @@ struct spi_controller {
 	 */
 	int			(*setup)(struct spi_device *spi);
 
+	/*
+	 * set_cs_timing() method is for SPI controllers that supports
+	 * configuring CS timing.
+	 *
+	 * This hook allows SPI client drivers to request SPI controllers
+	 * to configure specific CS timing through spi_set_cs_timing() after
+	 * spi_setup().
+	 */
+	void (*set_cs_timing)(struct spi_device *spi, u8 setup_clk_cycles,
+			      u8 hold_clk_cycles, u8 inactive_clk_cycles);
+
 	/* bidirectional bulk transfers
 	 *
 	 * + The transfer() method may not sleep; its main role is
-- 
2.20.1

