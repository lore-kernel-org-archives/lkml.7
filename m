Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF80C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D176120870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 07:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554708746;
	bh=9yS3auOxin1DL3oHF3phX3xEznWbeJQX/OP0tdcTrKc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=IWXHwHXP6/4CSQd2WhY1FjFbrJ3r2NMSwGovR6UgjtxRzCrZoN2O/i4uZxk+5O+u2
	 ZunNg/lx2rkFjL3pfCmO1orsVH7dG5vGsHKaVs/04O96pMoFnfs75bGWX0EO7vpAUw
	 R1rUFCtD5m5DSp/nOsBKHSliXXxn2JKouWoMQsiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfDHHcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 03:32:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44342 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfDHHcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 03:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ITrwBjYxRF02082MkJnJP0JWiVmsSZWqXgap45mz8Zw=; b=RDofjGNBViq+
        pUTAX9OZ6zRzFZJXx9ovBBD+qsUAL7Kg29L6UXQNw1wpVzm8nABYs+l0GKjywfsHwwl1skWAjv9/z
        TlGWmlErGt4JFbRro6SI90K3I0KrBA0itN8nZA6mYZCSSs5XdziizL3bKHUVPRQ3npnnzME28GRtK
        BHjyo=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDOlN-0003xl-0X; Mon, 08 Apr 2019 07:32:18 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id BC75D441D3C; Mon,  8 Apr 2019 14:32:06 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: tegra114: add dual mode support" to the spi tree
In-Reply-To:  <1554423259-26056-8-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190408073206.BC75D441D3C@finisterre.ee.mobilebroadband>
Date:   Mon,  8 Apr 2019 14:32:06 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: tegra114: add dual mode support

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

From 9877a347f2056f7aa4e770de9a20048ad288f545 Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Thu, 4 Apr 2019 17:14:07 -0700
Subject: [PATCH] spi: tegra114: add dual mode support

This patch adds support for dual mode SPI transfer.

Dual mode uses both MOSI and MISO lines in parallel where the data
is interleaved on MOSI and MISO lines increasing the throughput.

Packet from Tx FIFO is transmitted on both MOSI and MISO lines and
packet to Rx FIFO is received from both MOSI and MISO lines. Even
bits are transmitted or received on the MOSI data line and odd bits
are transmitted or received on the MISO data line.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 402799c7f6b7..1e749ce13029 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -786,6 +786,11 @@ static int tegra_spi_start_transfer_one(struct spi_device *spi,
 
 	total_fifo_words = tegra_spi_calculate_curr_xfer_param(spi, tspi, t);
 
+	if (t->rx_nbits == SPI_NBITS_DUAL || t->tx_nbits == SPI_NBITS_DUAL)
+		command1 |= SPI_BOTH_EN_BIT;
+	else
+		command1 &= ~SPI_BOTH_EN_BIT;
+
 	if (tspi->is_packed)
 		command1 |= SPI_PACKED;
 	else
@@ -1152,7 +1157,8 @@ static int tegra_spi_probe(struct platform_device *pdev)
 		master->max_speed_hz = 25000000; /* 25MHz */
 
 	/* the spi->mode bits understood by this driver: */
-	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST |
+			    SPI_TX_DUAL | SPI_RX_DUAL;
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	master->setup = tegra_spi_setup;
 	master->transfer_one_message = tegra_spi_transfer_one_message;
-- 
2.20.1

