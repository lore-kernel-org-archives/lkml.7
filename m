Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A6EC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D4C217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554434831;
	bh=PeosnoJsASLGHGDkcEr0qEqJS759tgZOGId3GXn/oLg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=l5sbWla9XOGJUqA6dRXtdjy0DnOXDwGgBOf5OicKDk4z7VkruITCXhkOP/OyAz1bC
	 VxlfY/q8bX021PgabE6WjbusMjCudw0IZHx2wKlYdQfYF0yQS0iJpM/X31lU3837ef
	 VPUrXoBtbc4RoehFURgYdOxwNKTdsbVD6v5FQwv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbfDED1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:27:11 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34304 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730206AbfDED1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=6GiShkSlUpQjLX2JiUpt8qcdBiDgg++yAgsf0vFVEZ0=; b=vm68pmyob70H
        vHbp93PxwBfj/0qHG8+EH5UgdT5Hvj0gQGcPEakqnx1naXlSQFg/j3WMr9VUSRpXTB4tWp9DU5KYN
        XOA/Qglu8f59iPuQsCBOW/CS5gP0rIbWu7eCbcXGrFlGemHKqaGaXfVls0sfxD6n5DPZp1uL0D8uO
        IoxEo=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hCFVJ-0005ga-Ud; Fri, 05 Apr 2019 03:26:58 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id ED4A8441D3D; Fri,  5 Apr 2019 10:26:54 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: tegra114: dump SPI registers during timeout" to the spi tree
In-Reply-To:  <1554423259-26056-5-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190405032654.ED4A8441D3D@finisterre.ee.mobilebroadband>
Date:   Fri,  5 Apr 2019 10:26:54 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: tegra114: dump SPI registers during timeout

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

From a0253c8fa18129f423c22f175a83d81423e60715 Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Thu, 4 Apr 2019 17:14:04 -0700
Subject: [PATCH] spi: tegra114: dump SPI registers during timeout

This patch dumps SPI registers on transfer error or timeout for debug
purpose.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 8c33bf056196..99019f6d2d84 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -874,6 +874,20 @@ static void tegra_spi_transfer_end(struct spi_device *spi)
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 }
 
+static void tegra_spi_dump_regs(struct tegra_spi_data *tspi)
+{
+	dev_dbg(tspi->dev, "============ SPI REGISTER DUMP ============\n");
+	dev_dbg(tspi->dev, "Command1:    0x%08x | Command2:    0x%08x\n",
+		tegra_spi_readl(tspi, SPI_COMMAND1),
+		tegra_spi_readl(tspi, SPI_COMMAND2));
+	dev_dbg(tspi->dev, "DMA_CTL:     0x%08x | DMA_BLK:     0x%08x\n",
+		tegra_spi_readl(tspi, SPI_DMA_CTL),
+		tegra_spi_readl(tspi, SPI_DMA_BLK));
+	dev_dbg(tspi->dev, "TRANS_STAT:  0x%08x | FIFO_STATUS: 0x%08x\n",
+		tegra_spi_readl(tspi, SPI_TRANS_STATUS),
+		tegra_spi_readl(tspi, SPI_FIFO_STATUS));
+}
+
 static int tegra_spi_transfer_one_message(struct spi_master *master,
 			struct spi_message *msg)
 {
@@ -920,6 +934,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 			    (tspi->cur_direction & DATA_DIR_RX))
 				dmaengine_terminate_all(tspi->rx_dma_chan);
 			ret = -EIO;
+			tegra_spi_dump_regs(tspi);
 			tegra_spi_flush_fifos(tspi);
 			reset_control_assert(tspi->rst);
 			udelay(2);
@@ -930,6 +945,7 @@ static int tegra_spi_transfer_one_message(struct spi_master *master,
 		if (tspi->tx_status ||  tspi->rx_status) {
 			dev_err(tspi->dev, "Error in Transfer\n");
 			ret = -EIO;
+			tegra_spi_dump_regs(tspi);
 			goto complete_xfer;
 		}
 		msg->actual_length += xfer->len;
@@ -971,6 +987,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_spi_data *tspi)
 			tspi->status_reg);
 		dev_err(tspi->dev, "CpuXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
+		tegra_spi_dump_regs(tspi);
 		tegra_spi_flush_fifos(tspi);
 		complete(&tspi->xfer_completion);
 		spin_unlock_irqrestore(&tspi->lock, flags);
@@ -1045,6 +1062,7 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_spi_data *tspi)
 			tspi->status_reg);
 		dev_err(tspi->dev, "DmaXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
+		tegra_spi_dump_regs(tspi);
 		tegra_spi_flush_fifos(tspi);
 		complete(&tspi->xfer_completion);
 		spin_unlock_irqrestore(&tspi->lock, flags);
-- 
2.20.1

