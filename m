Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD1CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20B3217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554108882;
	bh=bR4nvaNFg4L9/Y6cNfiuDu01LqR3EhuH/aqVKzmBhAc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=DjFpW7J1RiuJOIvknEd0L5DpQZhu5tpmKRjOnO8Y2N7Jjd6xMR5C5x3w6xOaX4l5Z
	 uxdG7AEzIgr4nF7D1cGEN8YDyYZ69Pyde/Ozb3x1mnsBnDptVz68bBeSjc9+mMfkny
	 uD+QzGReU9c7TBZHqMoUZFQjorgi0i8UEfL9z/cM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfDAIyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:54:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33498 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728840AbfDAIyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=YXNv/sDHaQ+qGFMtoiU9jZ7zR7qf08X7HCAbH9XYUlw=; b=s+lQpy7WNgAX
        C0koH0sqr9Ob4VYW0eUokCjRnXNe1dZybFxLbYIaWB52gcR/HcsMFPPX7KY8c9LpGSBcxMmUvFtX1
        miUmEeXO7JXSQ5FMxDBKz1IJQWfryGMfRLil1quApxHT1nk4Yxp5nkRY/BWC3LY0Gim4ktu331upI
        MXNb4=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAsi8-0008Pz-SL; Mon, 01 Apr 2019 08:54:33 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 16093440082; Mon,  1 Apr 2019 09:54:30 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Mark Brown <broonie@kernel.org>, thierry.reding@gmail.com,
        jonathanh@nvidia.com, talho@nvidia.com, skomatineni@nvidia.com,
        broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        kyarlagadda@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: tegra114: reset controller on probe" to the spi tree
In-Reply-To:  <1553666207-11414-11-git-send-email-skomatineni@nvidia.com>
X-Patchwork-Hint: ignore
Message-Id: <20190401085430.16093440082@finisterre.ee.mobilebroadband>
Date:   Mon,  1 Apr 2019 09:54:30 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: tegra114: reset controller on probe

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

From 019194933339b3e9b486639c8cb3692020844d65 Mon Sep 17 00:00:00 2001
From: Sowjanya Komatineni <skomatineni@nvidia.com>
Date: Tue, 26 Mar 2019 22:56:32 -0700
Subject: [PATCH] spi: tegra114: reset controller on probe

Fixes: SPI driver can be built as module so perform SPI controller reset
on probe to make sure it is in valid state before initiating transfer.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-tegra114.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 05bb2f9bff3c..09cfae3abce2 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1136,27 +1136,19 @@ static int tegra_spi_probe(struct platform_device *pdev)
 
 	spi_irq = platform_get_irq(pdev, 0);
 	tspi->irq = spi_irq;
-	ret = request_threaded_irq(tspi->irq, tegra_spi_isr,
-			tegra_spi_isr_thread, IRQF_ONESHOT,
-			dev_name(&pdev->dev), tspi);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
-					tspi->irq);
-		goto exit_free_master;
-	}
 
 	tspi->clk = devm_clk_get(&pdev->dev, "spi");
 	if (IS_ERR(tspi->clk)) {
 		dev_err(&pdev->dev, "can not get clock\n");
 		ret = PTR_ERR(tspi->clk);
-		goto exit_free_irq;
+		goto exit_free_master;
 	}
 
 	tspi->rst = devm_reset_control_get_exclusive(&pdev->dev, "spi");
 	if (IS_ERR(tspi->rst)) {
 		dev_err(&pdev->dev, "can not get reset\n");
 		ret = PTR_ERR(tspi->rst);
-		goto exit_free_irq;
+		goto exit_free_master;
 	}
 
 	tspi->max_buf_size = SPI_FIFO_DEPTH << 2;
@@ -1164,7 +1156,7 @@ static int tegra_spi_probe(struct platform_device *pdev)
 
 	ret = tegra_spi_init_dma_param(tspi, true);
 	if (ret < 0)
-		goto exit_free_irq;
+		goto exit_free_master;
 	ret = tegra_spi_init_dma_param(tspi, false);
 	if (ret < 0)
 		goto exit_rx_dma_free;
@@ -1186,18 +1178,32 @@ static int tegra_spi_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "pm runtime get failed, e = %d\n", ret);
 		goto exit_pm_disable;
 	}
+
+	reset_control_assert(tspi->rst);
+	udelay(2);
+	reset_control_deassert(tspi->rst);
 	tspi->def_command1_reg  = SPI_M_S;
 	tegra_spi_writel(tspi, tspi->def_command1_reg, SPI_COMMAND1);
 	pm_runtime_put(&pdev->dev);
+	ret = request_threaded_irq(tspi->irq, tegra_spi_isr,
+				   tegra_spi_isr_thread, IRQF_ONESHOT,
+				   dev_name(&pdev->dev), tspi);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
+			tspi->irq);
+		goto exit_pm_disable;
+	}
 
 	master->dev.of_node = pdev->dev.of_node;
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can not register to master err %d\n", ret);
-		goto exit_pm_disable;
+		goto exit_free_irq;
 	}
 	return ret;
 
+exit_free_irq:
+	free_irq(spi_irq, tspi);
 exit_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
@@ -1205,8 +1211,6 @@ static int tegra_spi_probe(struct platform_device *pdev)
 	tegra_spi_deinit_dma_param(tspi, false);
 exit_rx_dma_free:
 	tegra_spi_deinit_dma_param(tspi, true);
-exit_free_irq:
-	free_irq(spi_irq, tspi);
 exit_free_master:
 	spi_master_put(master);
 	return ret;
-- 
2.20.1

