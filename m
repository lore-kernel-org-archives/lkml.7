Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B4BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41D0218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 17:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552670389;
	bh=HtZPSUfHnssGc4G/XODYjY2zGDkRI4rXOYtoFbfl/80=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=a9FK+vcQUw6kXonkC0UVz9cnmIcirA+Cq7PolIqhZ+QSrfzehygDKugDS72HiPdcj
	 RWFHzpb+GVAOtyn0S2mxmJMcyQvR17LA/vUfvyPV0uSkDuCqsAg0w1opXYYUZ1Xl8x
	 zMBzFCfL6fk16L2bYkT4VVaPzAEZDsP188zD0u4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfCORTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 13:19:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54712 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbfCORTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 13:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=QAVoVYDuouSKxMFsDDiwqfSduskgs5SMg4RA3V2jBCU=; b=qyfPqQ8iH7Lr
        U+ksrLtuf+N2F+Lq78K3BxxvYjum9KdIgFmgxTy77jcsjKfqqsubhBDqvOLh+YOV9Lr2nhMVGH8Bm
        6VjxHNXCELxd0XOyEq50Ly4TKlyE1KIteZzw38Df4pzGNtSKzMFz+wjxFWoZMIqxlpvO9e0jSagRI
        yNFJs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h4qUf-0002fR-Fu; Fri, 15 Mar 2019 17:19:41 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 13BA01128AF5; Fri, 15 Mar 2019 17:19:41 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: rspi: Fix register initialization while runtime-suspended" to the spi tree
In-Reply-To:  <20190312184331.13755-1-geert+renesas@glider.be>
X-Patchwork-Hint: ignore
Message-Id: <20190315171941.13BA01128AF5@debutante.sirena.org.uk>
Date:   Fri, 15 Mar 2019 17:19:41 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: rspi: Fix register initialization while runtime-suspended

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

From 42bdaaece121b3bb50fd4d1203d6d0170279f9fa Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 12 Mar 2019 19:43:31 +0100
Subject: [PATCH] spi: rspi: Fix register initialization while
 runtime-suspended

The Renesas RSPI/QSPI driver performs SPI controller register
initialization in its spi_operations.setup() callback, without calling
pm_runtime_get_sync() first, which may cause spurious failures.

So far this went unnoticed, as this SPI controller is typically used
with a single SPI NOR FLASH containing the boot loader:
  1. If the device's module clock is still enabled (left enabled by the
     bootloader, and not yet disabled by the clk_disable_unused() late
     initcall), register initialization succeeds,
  2. If the device's module clock is disabled, register writes don't
     seem to cause lock-ups or crashes.
     Data received in the first SPI message may be corrupted, though.
     Subsequent SPI messages seem to be OK.
     E.g. on r8a7791/koelsch, one bit is lost while receiving the 6th
     byte of the JEDEC ID for the s25fl512s FLASH, corrupting that byte
     and all later bytes.  But until commit a2126b0a010905e5 ("mtd:
     spi-nor: refine Spansion S25FL512S ID"), the 6th byte was not
     considered for FLASH identification.

Fix this by moving all initialization from the .setup() to the
.prepare_message() callback.  The latter is always called after the
device has been runtime-resumed by the SPI core.

This also makes the driver follow the rule that .setup() must not change
global driver state or register values, as that might break a transfer
in progress.

Fixes: 490c97747d5dc77d ("spi: rspi: Add runtime PM support, using spi core auto_runtime_pm")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-rspi.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 556870dcdf79..b30fed824e66 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -868,28 +868,6 @@ static int qspi_transfer_one(struct spi_controller *ctlr,
 	}
 }
 
-static int rspi_setup(struct spi_device *spi)
-{
-	struct rspi_data *rspi = spi_controller_get_devdata(spi->controller);
-
-	rspi->max_speed_hz = spi->max_speed_hz;
-
-	rspi->spcmd = SPCMD_SSLKP;
-	if (spi->mode & SPI_CPOL)
-		rspi->spcmd |= SPCMD_CPOL;
-	if (spi->mode & SPI_CPHA)
-		rspi->spcmd |= SPCMD_CPHA;
-
-	/* CMOS output mode and MOSI signal from previous transfer */
-	rspi->sppcr = 0;
-	if (spi->mode & SPI_LOOP)
-		rspi->sppcr |= SPPCR_SPLP;
-
-	set_config_register(rspi, 8);
-
-	return 0;
-}
-
 static u16 qspi_transfer_mode(const struct spi_transfer *xfer)
 {
 	if (xfer->tx_buf)
@@ -959,8 +937,24 @@ static int rspi_prepare_message(struct spi_controller *ctlr,
 				struct spi_message *msg)
 {
 	struct rspi_data *rspi = spi_controller_get_devdata(ctlr);
+	struct spi_device *spi = msg->spi;
 	int ret;
 
+	rspi->max_speed_hz = spi->max_speed_hz;
+
+	rspi->spcmd = SPCMD_SSLKP;
+	if (spi->mode & SPI_CPOL)
+		rspi->spcmd |= SPCMD_CPOL;
+	if (spi->mode & SPI_CPHA)
+		rspi->spcmd |= SPCMD_CPHA;
+
+	/* CMOS output mode and MOSI signal from previous transfer */
+	rspi->sppcr = 0;
+	if (spi->mode & SPI_LOOP)
+		rspi->sppcr |= SPPCR_SPLP;
+
+	set_config_register(rspi, 8);
+
 	if (msg->spi->mode &
 	    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_RX_DUAL | SPI_RX_QUAD)) {
 		/* Setup sequencer for messages with multiple transfer modes */
@@ -1267,7 +1261,6 @@ static int rspi_probe(struct platform_device *pdev)
 	init_waitqueue_head(&rspi->wait);
 
 	ctlr->bus_num = pdev->id;
-	ctlr->setup = rspi_setup;
 	ctlr->auto_runtime_pm = true;
 	ctlr->transfer_one = ops->transfer_one;
 	ctlr->prepare_message = rspi_prepare_message;
-- 
2.20.1

