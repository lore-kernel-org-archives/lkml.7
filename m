Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC26C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 797FB217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 03:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554434829;
	bh=eipewHwhMv/jx0ePKRXJkZvvESHsVmuC2NT5opTlh5k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=YU4riAhc0ds1dUdJxHWBrm9Sq8+mgHTt3yTubIbcb9O/ab1BOnG6T8oR0LT9FgM52
	 yM+XRFhfDQxSPDEH8CzHeGesEfdvHk68nTmE5HvUe6B9mgw87NC0XdEZNcdUQVV65z
	 T/3/W94SrIS31MiqV5WcpQwmDbsff1etCRyGxmDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbfDED1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:27:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34234 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729820AbfDED1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 23:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=ZcyrGu2jyXpzeWQFNaEJ+IIFZc/HuJzaSC7BeLHG6xo=; b=Z3hRX6u59oPM
        jtfY5q0pGbGl5r9OhEWXP2zE/IwbSOIC1n/altN6LRHAjMmWvcukGlp2DQuzTnK3D9xLH0oeFFLPT
        VMukfzs8EZ2wGyVrLCvWDlmpWdK0oV3s9dxBD0KnDxUzwEFMEgX6F6Wg3NMWGGNaCvZrrPuMy/aaY
        D2WN0=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hCFVM-0005gk-PO; Fri, 05 Apr 2019 03:27:01 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id E0F6B441D3B; Fri,  5 Apr 2019 10:26:57 +0700 (+07)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: tegra114: avoid reset call in atomic context" to the spi tree
In-Reply-To:  <1554423259-26056-4-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190405032657.E0F6B441D3B@finisterre.ee.mobilebroadband>
Date:   Fri,  5 Apr 2019 10:26:57 +0700 (+07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: tegra114: avoid reset call in atomic context

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

From a026525d4e45e3d9690bffd0b05d018ff5638b5a Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Thu, 4 Apr 2019 17:14:03 -0700
Subject: [PATCH] spi: tegra114: avoid reset call in atomic context

This patch moves SPI controller reset out of spin lock.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 8de002fc6943..b57f10182fae 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -967,11 +967,12 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_spi_data *tspi)
 		dev_err(tspi->dev, "CpuXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
 		tegra_spi_flush_fifos(tspi);
+		complete(&tspi->xfer_completion);
+		spin_unlock_irqrestore(&tspi->lock, flags);
 		reset_control_assert(tspi->rst);
 		udelay(2);
 		reset_control_deassert(tspi->rst);
-		complete(&tspi->xfer_completion);
-		goto exit;
+		return IRQ_HANDLED;
 	}
 
 	if (tspi->cur_direction & DATA_DIR_RX)
@@ -1040,11 +1041,11 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_spi_data *tspi)
 		dev_err(tspi->dev, "DmaXfer 0x%08x:0x%08x\n",
 			tspi->command1_reg, tspi->dma_control_reg);
 		tegra_spi_flush_fifos(tspi);
+		complete(&tspi->xfer_completion);
+		spin_unlock_irqrestore(&tspi->lock, flags);
 		reset_control_assert(tspi->rst);
 		udelay(2);
 		reset_control_deassert(tspi->rst);
-		complete(&tspi->xfer_completion);
-		spin_unlock_irqrestore(&tspi->lock, flags);
 		return IRQ_HANDLED;
 	}
 
-- 
2.20.1

