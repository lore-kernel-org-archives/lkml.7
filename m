Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF4BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9ED213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554108885;
	bh=BAWGk4ouGF/EsRTzW0rJYtHaARbc8OTY5rB7ZK307H4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=f6a6tcTmykYyoSn+Yva3CjY0kDTeMwyot4ApPULTzNcHPR52B3Z2A9ZDt+OzZh9fU
	 vK85AvdhnjAkHrwz62r10jP8stepVj+8jYn+d54lyiNnuaet8ry8jjbyzzYelRJztV
	 wveDMJVNM4yTuZ473OMaKMa55pw9Zjes81jeTAWE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfDAIyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:54:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33650 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbfDAIym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:54:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=AiKqp+G1yqu4rMGyZGLNJB3K70pOTC9/LiIMzvCpiCk=; b=i5wW6zJoa6rT
        dItyMxOX27en1lhQiNptULCCaoffpbBwR2ORqgYY7Ztzb1E9VqAkk/3ofjHHByJ+J6in42mra1h2E
        5VvSevSSf+LXqiajPGNvhleO9QKvpOuQlDeQPU4nyCWcsL201QxM5T7HH/E99JmfD1oT9y022huPf
        QqFLo=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAsiD-0008QE-Nc; Mon, 01 Apr 2019 08:54:38 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id F3EBF440082; Mon,  1 Apr 2019 09:54:34 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: tegra114: flush fifos" to the spi tree
In-Reply-To:  <1553666207-11414-7-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190401085434.F3EBF440082@finisterre.ee.mobilebroadband>
Date:   Mon,  1 Apr 2019 09:54:34 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: tegra114: flush fifos

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

From c4fc9e5b28ff787e35137c2cc13316bb11d7657b Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Tue, 26 Mar 2019 22:56:28 -0700
Subject: [PATCH] spi: tegra114: flush fifos

Fixes: Flush TX and RX FIFOs before start of new transfer and on FIFO
overflow or underrun errors.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 39 +++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index a6153b905d1a..28aa080a94ff 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -499,22 +499,37 @@ static int tegra_spi_start_rx_dma(struct tegra_spi_data *tspi, int len)
 	return 0;
 }
 
-static int tegra_spi_start_dma_based_transfer(
-		struct tegra_spi_data *tspi, struct spi_transfer *t)
+static int tegra_spi_flush_fifos(struct tegra_spi_data *tspi)
 {
-	u32 val;
-	unsigned int len;
-	int ret = 0;
+	unsigned long timeout = jiffies + HZ;
 	u32 status;
 
-	/* Make sure that Rx and Tx fifo are empty */
 	status = tegra_spi_readl(tspi, SPI_FIFO_STATUS);
 	if ((status & SPI_FIFO_EMPTY) != SPI_FIFO_EMPTY) {
-		dev_err(tspi->dev, "Rx/Tx fifo are not empty status 0x%08x\n",
-			(unsigned)status);
-		return -EIO;
+		status |= SPI_RX_FIFO_FLUSH | SPI_TX_FIFO_FLUSH;
+		tegra_spi_writel(tspi, status, SPI_FIFO_STATUS);
+		while ((status & SPI_FIFO_EMPTY) != SPI_FIFO_EMPTY) {
+			status = tegra_spi_readl(tspi, SPI_FIFO_STATUS);
+			if (time_after(jiffies, timeout)) {
+				dev_err(tspi->dev,
+					"timeout waiting for fifo flush\n");
+				return -EIO;
+			}
+
+			udelay(1);
+		}
 	}
 
+	return 0;
+}
+
+static int tegra_spi_start_dma_based_transfer(
+		struct tegra_spi_data *tspi, struct spi_transfer *t)
+{
+	u32 val;
+	unsigned int len;
+	int ret = 0;
+
 	val = SPI_DMA_BLK_SET(tspi->curr_dma_words - 1);
 	tegra_spi_writel(tspi, val, SPI_DMA_BLK);
 
@@ -779,6 +794,9 @@ static int tegra_spi_start_transfer_one(struct spi_device *spi,
 	dev_dbg(tspi->dev, "The def 0x%x and written 0x%x\n",
 		tspi->def_command1_reg, (unsigned)command1);
 
+	ret = tegra_spi_flush_fifos(tspi);
+	if (ret < 0)
+		return ret;
 	if (total_fifo_words > SPI_FIFO_DEPTH)
 		ret = tegra_spi_start_dma_based_transfer(tspi, t);
 	else
@@ -876,6 +894,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			    (tspi->cur_direction & DATA_DIR_RX))
 				dmaengine_terminate_all(tspi->rx_dma_chan);
 			ret = -EIO;
+			tegra_spi_flush_fifos(tspi);
 			reset_control_assert(tspi->rst);
 			udelay(2);
 			reset_control_deassert(tspi->rst);
@@ -929,6 +948,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_spi_data *tspi)
 			tspi->status_reg);
 		dev_err(tspi->dev, "CpuXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
+		tegra_spi_flush_fifos(tspi);
 		reset_control_assert(tspi->rst);
 		udelay(2);
 		reset_control_deassert(tspi->rst);
@@ -1001,6 +1021,7 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_spi_data *tspi)
 			tspi->status_reg);
 		dev_err(tspi->dev, "DmaXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
+		tegra_spi_flush_fifos(tspi);
 		reset_control_assert(tspi->rst);
 		udelay(2);
 		reset_control_deassert(tspi->rst);
-- 
2.20.1

